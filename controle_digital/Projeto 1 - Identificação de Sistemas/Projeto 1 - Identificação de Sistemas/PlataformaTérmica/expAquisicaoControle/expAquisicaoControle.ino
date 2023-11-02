// Universidade Federal de Campina Grande
// Departamento de Engenharia Elétrica
// Graduação em Engenharia Elétrica

// Disciplina de Laboratório de Controle Digital
// Professores Péricles Rezende Barros e George Acioly Júnior

// Programa para aquisição de dados e controle PID em planta didática
// de temperatura multivariável

int indice1 = 0;
int indice2 = 0;
int indice3 = 0;
int indice4 = 0;
int indice5 = 0;
int indice6 = 0;
double Ts = 2; // Tempo de amostragem em segundos
int const comp = 50;

String incomingString;
String estadoSistema = "OFF";
String modoOperacao1 = "idle";
String modoOperacao2 = "idle";

int T1 = A4;
int U1 = 5;
double T1_valor = 0;
double DutyRef1 = 0;
double Duty1 = 0;
double kp1 = 0;
double ti1 = 0;
double ki1 = 0;
double r1 = 0;
double erro1 = 0;
double errop1 = 0;
double erroi1 = 0;
double ganhoFF1 = 0;
double taunumFF1 = 0;
double taudenFF1 = 0;
double atrasoFF1 = 0;
double An1;
double Bn1;
double Ad1;
double Bd1;
int d1;
double DutyVetor1[comp]; // vetor contendo valores do Duty Cycle 1
double Ud1[2];  // Vetor contendo contribuição do controle feedforward 1 para o sinal de controle
double DutyFF1;

int T2 = A5;
int U2 = 6;
double T2_valor = 0;
double DutyRef2 = 0;
double Duty2 = 0;
double kp2 = 0;
double ti2 = 0;
double ki2 = 0;
double r2 = 0;
double erro2 = 0;
double errop2 = 0;
double erroi2 = 0;
double ganhoFF2 = 0;
double taunumFF2 = 0;
double taudenFF2 = 0;
double atrasoFF2 = 0;
double An2;
double Bn2;
double Ad2;
double Bd2;
int d2;
double DutyVetor2[comp]; // vetor contendo valores do Duty Cycle 2
double Ud2[2];  // Vetor contendo contribuição do controle feedforward 2 para o sinal de controle
double DutyFF2;

double tdecorrido = 0;
double deltat = 0;

String inter = "intermediario";

void setup() {
  // TIMER SETUP- the timer interrupt allows preceise timed measurements of the reed switch
  //for mor info about configuration of arduino timers see http://arduino.cc/playground/Code/Timer1
  cli();//stop interrupts

  //set timer1 interrupt at 0.4 Hz
  TCCR1A = 0;// set entire TCCR1A register to 0
  TCCR1B = 0;// same for TCCR1B
  TCNT1  = 0;//initialize counter value to 0
  // set compare match register for 1/Ts Hz increments
  OCR1A = 15625;// = (16*10^6) / (Ts*1024) - 1 (must be <65536)
  // turn on CTC mode
  TCCR1B |= (1 << WGM12);
  // Set CS12 and CS10 bits for 1024 prescaler
  TCCR1B |= (1 << CS12) | (1 << CS10);
  // enable timer compare interrupt
  TIMSK1 |= (1 << OCIE1A);

  sei();//allow interrupts
  //END TIMER SETUP

  Serial.begin(9600);
}


ISR(TIMER1_COMPA_vect) { //timer1 interrupt 0.5 Hz

  //  Serial.print(incomingString);
  //  Serial.print("\n");

  if (estadoSistema == "OFF")
  {
    analogWrite(U1, 0);
    analogWrite(U2, 0);
    if (incomingString == "ON")
    {
      estadoSistema = "START1";
      incomingString = inter;
      Serial.print("LIGADO");
      //    Serial.print(", ");
      //    Serial.print(incomingString);
      Serial.print("\n");
    }
  }
  else if (estadoSistema == "START1" && incomingString != inter)
  {
    if (incomingString == "MA" || incomingString == "MF" || incomingString == "FF")
    {
      modoOperacao1 = incomingString;
      estadoSistema = "START2";
      incomingString = inter;
      Serial.print("Modo de Operacao 1: " + modoOperacao1);
      //      Serial.print(estadoSistema + " - Modo de Operação 1: " + modoOperacao1);
      //      Serial.print(", ");
      //      Serial.print(incomingString);
      Serial.print("\n");
    }
  }
  else if (estadoSistema == "START2" && incomingString != inter)
  {
    if (modoOperacao1 == "MA")
    {
      indice1 = incomingString.indexOf('y');
      indice2 = incomingString.length();
      DutyRef1 = incomingString.substring(indice1 + 2, indice2).toDouble();
    }
    else if (modoOperacao1 == "MF")
    {
      indice1 = incomingString.indexOf('C');
      indice2 = incomingString.indexOf(',');
      indice3 = incomingString.indexOf('f');
      indice4 = incomingString.length();
      kp1 = incomingString.substring(indice1 + 2, indice2).toDouble();
      ti1 = incomingString.substring(indice2 + 1, indice3 - 2).toDouble();
      ki1 = kp1 / ti1;
      DutyRef1 = incomingString.substring(indice3 + 2, indice4).toDouble();
      //incomingString = incomingString.substring(indice3 + 2, indice4);
    }
    else if (modoOperacao1 == "FF")
    {
      indice1 = incomingString.indexOf('=');
      indice2 = incomingString.indexOf(',');
      indice3 = incomingString.indexOf(',', indice2 + 1);
      indice4 = incomingString.indexOf(',', indice3 + 1);
      indice5 = incomingString.indexOf('y', indice4 + 2);
      indice6 = incomingString.length();
      ganhoFF1  = incomingString.substring(indice1 + 1, indice2).toDouble();
      taunumFF1 = incomingString.substring(indice2 + 1, indice3).toDouble();
      taudenFF1 = incomingString.substring(indice3 + 1, indice4).toDouble();
      atrasoFF1 = incomingString.substring(indice4 + 1, indice5).toDouble();
      DutyRef1 = incomingString.substring(indice5 + 2, indice6).toDouble();
      //incomingString = incomingString.substring(indice3 + 2, indice4);
      An1 = -(Ts + 2 * taunumFF1) * ganhoFF1;
      Bn1 = -(Ts - 2 * taunumFF1) * ganhoFF1;
      Ad1 = Ts + 2 * taudenFF1;
      Bd1 = Ts - 2 * taudenFF1;
      
      d1  = floor(atrasoFF1 / Ts);
    }

    estadoSistema = "START3";
    incomingString = inter;

    //    Serial.print(DutyRef1);
    //    Serial.print(estadoSistema);
    //    Serial.print(", ");
    //    Serial.print(incomingString);
    //    Serial.print("\n");
  }
  else if (estadoSistema == "START3" && incomingString != inter)
  {
    if (incomingString == "MA" || incomingString == "MF" || incomingString == "FF")
    {
      modoOperacao2 = incomingString;
      estadoSistema = "START4";
      incomingString = inter;

      Serial.print("Modo de Operacao 2: " + modoOperacao2);
      //      Serial.print(estadoSistema + " - Modo de Operação 2: " + modoOperacao2);
      //      Serial.print(", ");
      //      Serial.print(incomingString);
      Serial.print("\n");
    }
  }
  else if (estadoSistema == "START4" && incomingString != inter)
  {
    if (modoOperacao2 == "MA")
    {
      indice1 = incomingString.indexOf('y');
      indice2 = incomingString.length();
      DutyRef2 = incomingString.substring(indice1 + 2, indice2).toDouble();
    }
    else if (modoOperacao2 == "MF")
    {
      indice1 = incomingString.indexOf('C');
      indice2 = incomingString.indexOf(',');
      indice3 = incomingString.indexOf('f');
      indice4 = incomingString.length();
      kp2 = incomingString.substring(indice1 + 2, indice2).toDouble();
      ti2 = incomingString.substring(indice2 + 1, indice3 - 2).toDouble();
      ki2 = kp2 / ti2;
      DutyRef2 = incomingString.substring(indice3 + 2, indice4).toDouble();
      //incomingString = incomingString.substring(indice3 + 2, indice4);
    }
    else if (modoOperacao2 == "FF")
    {
      indice1 = incomingString.indexOf('=');
      indice2 = incomingString.indexOf(',');
      indice3 = incomingString.indexOf(',', indice2 + 1);
      indice4 = incomingString.indexOf(',', indice3 + 1);
      indice5 = incomingString.indexOf('y', indice4 + 2);
      indice6 = incomingString.length();
      ganhoFF2  = incomingString.substring(indice1 + 1, indice2).toDouble();
      taunumFF2 = incomingString.substring(indice2 + 1, indice3).toDouble();
      taudenFF2 = incomingString.substring(indice3 + 1, indice4).toDouble();
      atrasoFF2 = incomingString.substring(indice4 + 1, indice5).toDouble();
      DutyRef2 = incomingString.substring(indice5 + 2, indice6).toDouble();
      An2 = -(Ts + 2 * taunumFF2) * ganhoFF2;
      Bn2 = -(Ts - 2 * taunumFF2) * ganhoFF2;
      Ad2 = Ts + 2 * taudenFF2;
      Bd2 = Ts - 2 * taudenFF2;
      d2  = floor(atrasoFF2 / Ts);
      //incomingString = incomingString.substring(indice3 + 2, indice4);
    }


    //    Serial.print(DutyRef2);

    incomingString = String(DutyRef1, 3) + "," + String(DutyRef2, 3);
    estadoSistema = "ON";
    //    Serial.print(r1);
    Serial.print(estadoSistema);
    //    Serial.print(", ");
//        Serial.print(incomingString);
        Serial.print("\n");

  }
  else if (estadoSistema == "ON")
  {
    if (incomingString == "OFF")
    {
      Duty1 = 0.01;
      Duty2 = 0.01;
      r1 = 0;
      r2 = 0;
      erro1 = 0;
      erro2 = 0;

      estadoSistema = "OFF";
      modoOperacao1 = "idle";
      modoOperacao2 = "idle";
      analogWrite(U1, 0);
      analogWrite(U2, 0);
    }
    else
    {
      indice1 = incomingString.indexOf(',');
      indice2 = incomingString.length();

      T1_valor = analogRead(T1) * 0.0977;
      T2_valor = analogRead(T2) * 0.0977;
      deltat = (millis() - tdecorrido) * 0.001;
      tdecorrido = millis();

      if (modoOperacao1 == "MA")
      {
        Duty1 = incomingString.substring(0, indice1).toDouble();
        r1 = T1_valor;
        DutyFF1 = 0;
      }
      else if (modoOperacao1 == "MF")
      {
        r1 = incomingString.substring(0, indice1).toDouble();
        erro1 = r1 - T1_valor;
        errop1 = erro1 * (kp1);
        erroi1 += erro1 * (ki1) * deltat;
        Duty1 = errop1 + erroi1;
        DutyFF1 = 0;
      }
      else if (modoOperacao1 == "FF")
      {
          Duty1 = incomingString.substring(0, indice1).toDouble();
          for (int k = comp-1; k >= 1; k--)
          {
            DutyVetor1[k] = DutyVetor1[k - 1];
          }
          DutyVetor1[0] = Duty1;
          Ud1[1] = Ud1[0];
          DutyFF1 = (An1 * DutyVetor1[0 + d1] + Bn1 * DutyVetor1[1 + d1] 
                      - Bd1 * Ud1[1]) / Ad1;
          Ud1[0] = DutyFF1;
      }

      if (modoOperacao2 == "MA")
      {
        Duty2 = incomingString.substring(indice1 + 1, indice2).toDouble();
        r2 = T2_valor;
        DutyFF2 = 0;
      }
      else if (modoOperacao2 == "MF")
      {
        r2 = incomingString.substring(indice1 + 1, indice2).toDouble();
        erro2 = r2 - T2_valor;
        errop2 = erro2 * (kp2);
        erroi2 += erro2 * (ki2) * deltat;
        Duty2 = errop2 + erroi2;
        DutyFF2 = 0;
      }
      else if (modoOperacao2 == "FF")
      {
          Duty2 = incomingString.substring(indice1 + 1, indice2).toDouble();
          for (int k = comp-1; k >= 1; k--)
          {
            DutyVetor2[k] = DutyVetor2[k - 1];
          }
          DutyVetor2[0] = Duty2;
          Ud2[1] = Ud2[0];
          DutyFF2 = (An2 * DutyVetor2[0 + d2] + Bn2 * DutyVetor2[1 + d2] 
                      - Bd2 * Ud2[1]) / Ad2;
          Ud2[0] = DutyFF2;
      }

      Duty1 = Duty1 + DutyFF2;
      Duty2 = Duty2 + DutyFF1;
      
      // Saturação
      if (Duty1 >= 1)
        Duty1 = 1;
      else if (Duty1 <= 0)
        Duty1 = 0;

      if (Duty2 >= 1)
        Duty2 = 1;
      else if (Duty2 <= 0)
        Duty2 = 0;


      //T1_valor = analogRead(T1);
    //T2_valor = analogRead(T2);
    Serial.print(r1);
    Serial.print(",");
    Serial.print(r2);
    Serial.print(",");
    Serial.print(T1_valor);
    Serial.print(",");
    Serial.print(T2_valor);
    Serial.print(",");
    Serial.print(Duty1);
    Serial.print(",");
    Serial.print(Duty2);
    Serial.print("\n");

    analogWrite(U1, 255 * Duty1);
    analogWrite(U2, 255 * Duty2);
    }
  }

//    Serial.print(analogRead(T1) * 0.0977);
//    Serial.print(",");
//    Serial.print(analogRead(T2) * 0.0977);
//    Serial.print("\n");
}


void loop() {

  if (Serial.available() > 0)
    incomingString = Serial.readString();
  //Serial.print(incomingString);

}

#include "version.h"

#ifndef FW_VER
  #define FW_VER "N/A"
#endif

#ifndef COMMIT_NUMBER
  #define COMMIT_NUMBER "N/A"
#endif

#ifndef COMMIT_DATE
  #define COMMIT_DATE "N/A"
#endif

#ifndef COMMIT_BRANCH
  #define COMMIT_BRANCH "N/A"
#endif

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  
  Serial.println("FW VER:"+String(FW_VER)); 
  Serial.println("COMMIT NUMBER:"+String(COMMIT_NUMBER)); 
  Serial.println("COMMIT DATE:"+String(COMMIT_DATE)); 
  Serial.println("COMMIT BRANCH:"+String(COMMIT_BRANCH)); 
  }

void loop() {  
  // put your main code here, to run repeatedly:

}

/* ============================================================================

      Vídeo Aula de Engenharia Eletrônica WR Kits n° 172
      
      Watchgod Externo para Microcontroladores
      

      Dispositivo que reinicia o processador em caso de falha
      
      MCU: PIC12F629     Clock: 4MHz (interno)
      
      
      Autor: Eng. Wagner Rambo   Data: Junho de 2017
      
      
      www.wrkits.com.br | facebook.com/wrkits | youtube.com/canalwrkits

============================================================================ */


// ============================================================================
// --- Variáveis Globais ---
int wtd_counter = 0x00;                        //Contador para estouro do WTD


// ============================================================================
// --- Interrupção ---
void interrupt()
{
    if(INTF_bit)                               //Houve interrupção externa?
    {                                          //Sim...
        INTF_bit = 0x00;                       //limpa flag
        wtd_counter = 0x00;                    //reinicia wtd_counter
        GP4_bit = 0x01;                        //Seta GP4 (para MCUs com reset em LOW)
        GP5_bit = 0x00;                        //Limpa GP5 (para MCUs com reset em HIGH)
    
    
    } //end INTF_bit


} //end interrupt


// ============================================================================
// --- Função Principal ---
void main() 
{
    CMCON      = 0x07;                         //Desabilita os comparadores internos
    INTCON     = 0x90;                         //Habilita interrupção global
                                               //Habilita interrupção externa

    TRISIO     = 0x0F;                         //Configura GP4 e GP5 como saída
    GPIO       = 0x0F;                         //Inicializa GPIO
    
    while(1)                                   //Loop Infinito
    {
       wtd_counter++;                          //Incrementa wtd_counter
       delay_ms(1);                            //a cada 1ms
       
       if(wtd_counter == 60)                   //chegou em 60ms?
       {                                       //Sim...
          wtd_counter = 0x00;                  //Reinicia wtd_counter
          GP4_bit = ~GP4_bit;                  //inverte estado de GP4
          GP5_bit = ~GP5_bit;                  //inverte estado de GP5
       
       } //end if
    
    } //end while

} //end main






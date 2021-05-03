#line 1 "C:/You Tube - Meu Canal/06 Vídeo Aula Engenharia Eletrônica/Vídeo Aula 172 - Watchdog Externo para Microcontroladores 02-06-2017/vAula172_WR_Files/watchdog_source_file/pic12f629_wtd_source.c"





int wtd_counter = 0x00;





void interrupt()
{
 if(INTF_bit)
 {
 INTF_bit = 0x00;
 wtd_counter = 0x00;
 GP4_bit = 0x01;
 GP5_bit = 0x00;


 }


}




void main()
{
 CMCON = 0x07;
 INTCON = 0x90;


 TRISIO = 0x0F;
 GPIO = 0x0F;

 while(1)
 {
 wtd_counter++;
 delay_ms(1);

 if(wtd_counter == 60)
 {
 wtd_counter = 0x00;
 GP4_bit = ~GP4_bit;
 GP5_bit = ~GP5_bit;

 }

 }

}

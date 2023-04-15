module sinyalizasyon (input clk, input rst, output reg[5:0] led);
reg[23:0] counter;
reg[5:0] counter2;  // 0.5 saniye sayacı

always @ (posedge clk or negedge rst) begin


    if(!rst) begin
        counter <= 24'd0; // butondan reset çağrısı geldiğinde counterlar sıfırlanır
        counter2 <= 6'd0;
    end
    else if (counter2 > 6'd34)
        counter2 <=6'd0;    // 17. saniyeden sonra tekrar sıfırıncı saniyeye geçilir
    else if( counter < 24'd1349_9999)
        counter <= counter + 1;
    else begin
        counter2 <= counter2 + 1;
        counter <= 24'd0;
    end


end

always @ (posedge clk or negedge rst) begin
    // tang nano 9k da rgb led olmadığı için her renk için iki farklı led çalıştırıyorum
    if(!rst)
        led <= 6'b111100;   
    else if ( counter2 == 6'd0) // 0. saniyede kırmızı (üst ikili) led yanıyor 
        led <= 6'b111100;
    else if ( counter2 == 6'd20) // 10. saniyede sarı (orta ikili) led yanıyor
        led <= 6'b110011;
    else if ( counter2 == 6'd24) // 12. saniyede yeşil (alt ikili) led yanıyor 17. saniyeye kadar devam edip döngü tekrarlanıyor
        led <= 6'b001111;
    else
        led <= led;
end

endmodule
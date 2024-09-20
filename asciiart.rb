require 'dxruby'

class AsciiArt
  def initialize
    @ASCII_CHAR_SIZE=16
    @ASCII_FRONT=Image.new(@ASCII_CHAR_SIZE,@ASCII_CHAR_SIZE,C_WHITE)
    @ASCII_BACK=Image.new(@ASCII_CHAR_SIZE,@ASCII_CHAR_SIZE,C_BLACK)
    
    @data=Array.new(1){Array.new(1)}

#    @size_x=@data[0].length
#    @size_y=@data.length
  end

  def print
    i=0
    #p @data
    @data.each do |line_data|
      #p line_data
      j=0
      line_data.each{ |culumn_data|
        #p culumn_data
        if culumn_data==1
          Window.draw(j*@ASCII_CHAR_SIZE,i*@ASCII_CHAR_SIZE,@ASCII_FRONT)
        elsif culumn_data==0
          Window.draw(j*@ASCII_CHAR_SIZE,i*@ASCII_CHAR_SIZE,@ASCII_BACK)
        end
        j+=1
      }
      i+=1
    end
  end

  def puts_debug
    p @data
  end

  def setData(data)
    @data=data
  end

  def getData
    return @data
  end
end
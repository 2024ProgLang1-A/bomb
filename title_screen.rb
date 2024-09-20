require 'dxruby'
require './asciiart'

#Ascii Art made at https://lazesoftware.com/ja/tool/hugeaagen/

class TitleScreen < AsciiArt
  def initialize
    super

    @data=[
      [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0],
      [1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0],
      [1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0],
      [1,1,0,0,0,0,0,1,0,0,0,1,1,1,1,0,0,0,1,0,1,1,1,1,0,1,1,1,1,0,0,0,1,0,1,1,1,1,0,0],
      [1,1,0,0,0,0,1,0,0,0,1,0,0,0,0,1,0,0,1,1,0,0,0,1,1,0,0,0,1,1,0,0,1,1,0,0,0,0,1,0],
      [1,1,1,1,1,1,1,0,0,0,1,0,0,0,0,0,1,0,1,0,0,0,0,0,1,0,0,0,0,1,0,0,1,0,0,0,0,0,1,0],
      [1,1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,1,0,1,0,0,0,0,0,1,0,0,0,0,1,0,0,1,0,0,0,0,0,1,0],
      [1,1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,1,0,1,0,0,0,0,0,1,0,0,0,0,1,0,0,1,0,0,0,0,0,1,0],
      [1,1,0,0,0,0,0,1,0,0,1,0,0,0,0,1,0,0,1,0,0,0,0,0,1,0,0,0,0,1,0,0,1,1,0,0,0,0,1,0],
      [1,1,1,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,1,0,0,0,0,0,1,0,0,0,0,1,0,0,1,0,1,1,1,1,0,0]
    ]

#    @data=[[0,1],[1,0]]
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
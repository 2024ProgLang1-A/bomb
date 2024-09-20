#bomberman main ruby file
require 'dxruby'
require './enemy'
require './bomb'
#require './asciiart'
require './title_screen'

def mapInit
  $map = [[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
        [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
      ]

  max = 5
  for i in 1..14
    for j in 0..max
      tmp = rand(1..1008) % 14 + 1
      $map[i][tmp] = 2
    end
  end

  max = 2
  for i in 1..14
    for j in 0..max
      tmp = rand(1..1008) % 14 + 1
      $map[i][tmp] = 1
    end
  end
  #スタート地点が埋まっていることを避ける
  $map[1][1] = 0
  $map[1][2] = 0
  $map[2][1] = 0
  $map[2][2] = 0
end

bombrx=0
bombry=0


empty=Image.new(16, 16, [0, 0, 0, 0])#0
block = Image.new(16, 16, [255, 255, 255, 255])#1
brock = Image.new(16, 16, [255, 115, 78, 48])#2
bombed=Image.new(16,16,[255,255,255,0])#4
image = Array.new(4) {Array.new(3) {Image.new(256, 256)}}
jibun = [Image.new(16,16).triangle_fill(8,0,0,8,16,8,C_GREEN),
         Image.new(16,16).triangle_fill(0,8,16,8,8,16,C_GREEN),
         Image.new(16,16).triangle_fill(8,0,16,8,8,16,C_GREEN),
         Image.new(16,16).triangle_fill(8,0,0,8,8,16,C_GREEN)]

$enemynum=4
def enemyInit
  $enemy=[]
  $enemyc=0
  for num in 0..$enemynum-1 do
      $enemy[num]=Enemy.new
      $enemyc+=1
  end
end

def gameInit
  $x=1
  $y=1
  $angle=2
  mapInit
  enemyInit
end
bomb=Bomb.new

title_screen=TitleScreen.new
title_font=Font.new(16,"Arial",)
titleFlag=true;

Window.loop do
  if titleFlag
#    p "title"
#    title_screen.puts_debug
    title_screen.print
    Window.draw_font(32,16*(title_screen.getData.length+5),"Press Enter Key to start",title_font,)
    if Input.key_push?(K_RETURN)
      titleFlag=false
      gameInit
    end
  else
    if Input.key_push?(K_W)
      if $map[$y-1][$x]==0
        $angle=0
        $y-=1
      end
    end
    if Input.key_push?(K_S)
      if $map[$y+1][$x]==0
        $angle=1
        $y+=1
      end
    end
    if Input.key_push?(K_D)
      if $map[$y][$x+1]==0
        $angle=2
        $x+=1
      end
    end
    if Input.key_push?(K_A)
      if $map[$y][$x-1]==0
        $angle=3
        $x-=1
      end
    end

#    if Input.key_push?(K_SPACE)
#      bomb.put($x,$y,$angle)
#    end
    if Input.key_push?(K_SPACE)
      bombrx=rand(0..3)
      bombry=rand(0..3)
      bomb.put($x,$y,$angle,bombrx,bombry)
    end
    # 右のマップ
    for i in 0..15
      for j in 0..15
          Window.draw(j * 16 + 288, i * 16, empty) if $map[i][j] == 0
          Window.draw(j * 16 + 288, i * 16, block) if $map[i][j] == 1
          Window.draw(j * 16 + 288, i * 16, brock) if $map[i][j] == 2
          Window.draw(j * 16 + 288, i * 16, bombed) if $map[i][j] == 4
      end
    end

    # 自分（赤の四角だけど）描画

    Window.draw($x * 16 + 288, $y * 16, jibun[$angle])
    bomb.expl
    bomb.draw 
    for num in 0..$enemynum-1 do
      if $enemy[num]==nil
          next
      end

      if $map[$enemy[num].getCoord_y][$enemy[num].getCoord_x]==4
          $enemy[num]=nil
          $enemyc-=1
          next
      end
      $enemy[num].move
      $enemy[num].draw
    end
    if $enemyc==0
      titleFlag=true
    end
    break if Input.keyPush?(K_ESCAPE)
  end
end

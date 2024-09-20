#bomberman main ruby file
require 'dxruby'
require './enemy'
require './bomb'
#require './asciiart'
require './title_screen'
require './gameover_screen'
require './gameclear_screen'

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
font1=Font.new(30, "MS 明朝",weight: true)
Window.height = 512  

empty=Image.new(32, 32, [0, 0, 0, 0])
block = Image.new(32, 32, [255, 255, 255, 255])
brock = Image.new(32, 32, [255, 115, 78, 48])
bombed=Image.new(32,32,[255,255,255,0])

playerpre=Image.load_tiles('player.png',3,4)
player=[playerpre[9],playerpre[0],playerpre[6],playerpre[3]]

image = Array.new(4) {Array.new(3) {Image.new(256, 256)}}

$enemynum=1
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
  $health=120
end
bomb=Bomb.new

title_screen=TitleScreen.new
title_font=Font.new(30,"Arial",)
gameover_screen=GameoverScreen.new
gameover_font=title_font
gameclear_screen=GameclearScreen.new
gameclear_font=title_font
titleFlag=true
gameoverFlag=false
gameclearFlag=false

Window.loop do
  if (titleFlag&&!gameoverFlag&&!gameclearFlag)
#    p "title"
#    title_screen.puts_debug
    title_screen.print
    Window.draw_font(32,16*(title_screen.getData.length+5),"Press Enter Key to start",title_font,)
    if Input.key_push?(K_RETURN)
      titleFlag=false
      gameInit
    end
  elsif (!titleFlag&&gameoverFlag&&!gameclearFlag)
    gameover_screen.print
    Window.draw_font(32,16*(gameover_screen.getData.length+5),"Press Space Key to go Title",gameover_font,)
    if Input.key_push?(K_SPACE)
      titleFlag=true
      gameoverFlag=false
    end
  elsif (!titleFlag&&!gameoverFlag&&gameclearFlag)
    gameclear_screen.print
    Window.draw_font(32,16*(gameclear_screen.getData.length+5),"Press Space Key to go Title",gameclear_font,)
    if Input.key_push?(K_SPACE)
      titleFlag=true
      gameclearFlag=false
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
          Window.draw(j * 32 + 72, i * 32, empty) if $map[i][j] == 0
          Window.draw(j * 32 + 72, i * 32, block) if $map[i][j] == 1
          Window.draw(j * 32 + 72, i * 32, brock) if $map[i][j] == 2
          Window.draw(j * 32 + 72, i * 32, bombed) if $map[i][j] == 4
      end
    end

    # 自分（赤の四角だけど）描画

    Window.draw($x * 32 + 72, $y * 32, player[$angle])
    bomb.expl
    bomb.draw 
    Window.draw_font(0,0,"♡×#{$health/30}".to_s,font1,color: C_WHITE)

    if $map[$y][$x]==4
        $health-=1
    end
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
      gameclearFlag=true
    end
    if $health<=0
      gameoverFlag=true
    end
    break if Input.keyPush?(K_ESCAPE)
  end
end

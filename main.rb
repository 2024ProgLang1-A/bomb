#bomberman main ruby file
require 'dxruby'
require './enemy'
require './bomb'
#require './asciiart'
require './title_screen'

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

x = 1
y = 1
angle = 2

empty=Image.new(16, 16, [0, 0, 0, 0])
block = Image.new(16, 16, [255, 255, 255, 255])
brock = Image.new(16, 16, [255, 115, 78, 48])
bombed=Image.new(16,16,[255,255,255,0])
image = Array.new(4) {Array.new(3) {Image.new(256, 256)}}
jibun = [Image.new(16,16).triangle_fill(8,0,0,8,16,8,C_GREEN),
         Image.new(16,16).triangle_fill(0,8,16,8,8,16,C_GREEN),
         Image.new(16,16).triangle_fill(8,0,16,8,8,16,C_GREEN),
         Image.new(16,16).triangle_fill(8,0,0,8,8,16,C_GREEN)]

=begin
class Bomb
    def initialize
        @bx=0
        @by=0
        @exist=false
        @time=0
        @count=0
        @bombed_x=0
        @bombed_y=0
    end
    def put(x,y,angle)
        if @exist==false 
            case angle
                when 0 then
                    if $map[y][x]==0
                        @bx=x
                        @by=y
                        @exist=true
                    end
                when 1 then
                    if $map[y][x]==0
                        @bx=x
                        @by=y
                        @exist=true
                    end
                when 2 then
                    if $map[y][x]==0
                        @bx=x
                        @by=y
                        @exist=true
                    end
                when 3 then
                    if $map[y][x]==0
                        @bx=x
                        @by=y
                        @exist=true
                    end
            end
            $map[@by][@bx]=3
            @time=0
        end
    end
    def expl
        @time+=1
        @count+=1
        if @time>180 && @exist
            @count=0
            for i in -1..1 do
                for j in -1..1 do
                    if $map[@by+i][@bx+j]!=1
                        $map[@by+i][@bx+j]=4
                    end   
                end
            end
            @exist=false
            @bombed_x=@bx
            @bombed_y=@by
        end
        if @count>=30 && @bombed_x!=0
            for i in -1..1 do
                for j in -1..1 do
                    if $map[@bombed_y+i][@bombed_x+j]==4
                        $map[@bombed_y+i][@bombed_x+j]=0
                    end   
                end
            end
            @bombed_x=0
            @bombed_y=0
        end
    end
    def draw
        if @exist==true
            #Window.draw(@bx * 16 + 288, @by * 16, Image.new.circle_fill(@bx,@by,8,C_YELLOW))
            #Image.new.circle_fill(@bx.to_f,@by.to_f,8,C_YELLOW)
            #Image.circle_fill(@bx.to_f, @by.to_f, 8, C_YELLOW)
            img_ball = Image.new(16, 16).circle_fill(8.0, 8.0, 8, C_YELLOW)
            ball = Sprite.new(@bx *16+288, @by*16, img_ball)
            ball.draw
        end
    end
end
=end
=begin
class Enemy
    def initialize
        @i=0
        @angle=1
        @ex=rand(1..14)
        @ey=rand(1..14)
        while $map[@ey][@ex]==1 do
            @ex=rand(1..14)
            @ey=rand(1..14)
        end
        @images=[Image.new(16,16).triangle_fill(8,0,0,8,16,8,C_RED),
        Image.new(16,16).triangle_fill(0,8,16,8,8,16,C_RED),
        Image.new(16,16).triangle_fill(8,0,16,8,8,16,C_RED),
        Image.new(16,16).triangle_fill(8,0,0,8,8,16,C_RED)]

    end
    def getCoord_x
        return @ex
    end

    def getCoord_y
        return @ey
    end

    def move
        @i+=1
        if @i%20==0 
            move=rand(0..4)
            if move==0
                if $map[@ey-1][@ex]==0
                    @angle=0
                    @ey-=1
                end
            end
            if move==1
                if $map[@ey+1][@ex]==0
                    @angle=1
                    @ey+=1
                end
            end
            if move==2
                if $map[@ey][@ex+1]==0
                    @angle=2
                    @ex+=1
                end
            end
            if move==3
                if $map[@ey][@ex-1]==0
                    @angle=3
                    @ex-=1
                end
            end
        end
    end

    def draw
        Window.draw(@ex * 16 + 288, @ey * 16, @images[@angle])
    end
end 
=end

enemynum=4
enemy=[]
enemyc=0
for num in 0..enemynum-1 do
    enemy[num]=Enemy.new
    enemyc+=1
end

bomb=Bomb.new

title_screen=TitleScreen.new
title_font=Font.new(16,"Arial",)
titleFlag=true;

Window.loop do
  if titleFlag
    p "title"
#    title_screen.puts_debug
    title_screen.print
    Window.draw_font(32,16*(title_screen.getData.length+5),"Press Enter Key to start",title_font,)
    titleFlag=false if Input.key_push?(K_RETURN)
  else
    if Input.key_push?(K_W)
      if $map[y-1][x]==0
      angle=0
      y-=1
      end
    end
    if Input.key_push?(K_S)
      if $map[y+1][x]==0
          angle=1
          y+=1
      end
    end
    if Input.key_push?(K_D)
      if $map[y][x+1]==0
          angle=2
          x+=1
      end
    end
    if Input.key_push?(K_A)
      if $map[y][x-1]==0
          angle=3
          x-=1
      end
    end

    if Input.key_push?(K_SPACE)
      bomb.put(x,y,angle)
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

    Window.draw(x * 16 + 288, y * 16, jibun[angle])
    bomb.expl
    bomb.draw 
    for num in 0..enemynum-1 do
      if enemy[num]==nil
          next
      end

      if $map[enemy[num].getCoord_y][enemy[num].getCoord_x]==4
          enemy[num]=nil
          enemyc-=1
          next
      end
      enemy[num].move
      enemy[num].draw
    end
    if enemyc==0
      titleFlag=true
    end
    break if Input.keyPush?(K_ESCAPE)
  end
end

#bomberman main ruby file
#!ruby -Ks
# DXRuby サンプル ３Ｄ迷路
require 'dxruby'
require './enemy'
require './bomb'

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

enemy=[]
enemyc=0
for num in 0..1 do
    enemy[num]=Enemy.new
    enemyc+=1
end
bomb=Bomb.new
Window.loop do
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
    bombrx=rand(0..3)
    bombry=rand(0..3)
    bomb.put(x,y,angle,bombrx,bombry)
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
  for num in 0..1 do
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
    break
  end
  break if Input.keyPush?(K_ESCAPE)
end

#bomberman main ruby file
#!ruby -Ks
# DXRuby サンプル ３Ｄ迷路
require 'dxruby'

# マップ
map = [[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
       [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
       [1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1],
       [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1],
       [1, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 1, 0, 1],
       [1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1],
       [1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1],
       [1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1],
       [1, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 1],
       [1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1],
       [1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1],
       [1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1],
       [1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1],
       [1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1, 0, 1],
       [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1],
       [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
      ]

x = 1
y = 1
angle = 2

# 向きによる増分
angledata = [[0, -1], [1, 0], [0, 1], [-1, 0]]

block = Image.new(16, 16, [255, 255, 255, 255])
image = Array.new(4) {Array.new(3) {Image.new(256, 256)}}
jibun = [Image.new(16,16).triangle_fill(8,0,0,8,16,8,C_GREEN),
         Image.new(16,16).triangle_fill(0,8,16,8,8,16,C_GREEN),
         Image.new(16,16).triangle_fill(8,0,16,8,8,16,C_GREEN),
         Image.new(16,16).triangle_fill(8,0,0,8,8,16,C_GREEN)]

# 3D画像生成
# 計算でかなり強引に作っている
# それぞれの距離ごとに綺麗な画像を作って読み込んだほうがよいと思います

Window.loop do
   #左右おした
  
  #angle += Input.x if Input.padPush?(P_LEFT) or Input.padPush?(P_RIGHT)
  #angle = 0 if angle > 3
  #angle = 3 if angle < 0

  # 上おした
  #if Input.padPush?(P_UP) or Input.padPush?(P_DOWN)
   # newx = x + angledata[angle - Input.y - 1][0]
    #newy = y + angledata[angle - Input.y - 1][1]
    #x, y = newx, newy if map[newy][newx] == 0
  #end
  if Input.padPush?(P_UP)
    if map[y-1][x]==0
    angle=0
    y-=1
    end
  end
  if Input.padPush?(P_DOWN)
    if map[y+1][x]==0
    angle=1
    y+=1
    end
  end
  if Input.padPush?(P_RIGHT)
    if map[y][x+1]==0
        angle=2
    x+=1
    end
  end
  if Input.padPush?(P_LEFT)
    if map[y][x-1]==0
        angle=3
    x-=1
    end
  end
  # 右のマップ
  for i in 0..15
    for j in 0..15
      Window.draw(j * 16 + 288, i * 16, block) if map[i][j] == 1
    end
  end

  # 自分（赤の四角だけど）描画
  Window.draw(x * 16 + 288, y * 16, jibun[angle])

  break if Input.keyPush?(K_ESCAPE)
end

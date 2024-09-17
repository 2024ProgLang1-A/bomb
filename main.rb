#bomberman main ruby file
#!ruby -Ks
# DXRuby サンプル ３Ｄ迷路
require 'dxruby'

# マップ
$map = [[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
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

block = Image.new(16, 16, [255, 255, 255, 255])
image = Array.new(4) {Array.new(3) {Image.new(256, 256)}}
jibun = [Image.new(16,16).triangle_fill(8,0,0,8,16,8,C_GREEN),
         Image.new(16,16).triangle_fill(0,8,16,8,8,16,C_GREEN),
         Image.new(16,16).triangle_fill(8,0,16,8,8,16,C_GREEN),
         Image.new(16,16).triangle_fill(8,0,0,8,8,16,C_GREEN)]
class Enemy
    def initialize
        @i=0
        @angle=1
        @ex=1
        @ey=4
        @images=[Image.new(16,16).triangle_fill(8,0,0,8,16,8,C_RED),
        Image.new(16,16).triangle_fill(0,8,16,8,8,16,C_RED),
        Image.new(16,16).triangle_fill(8,0,16,8,8,16,C_RED),
        Image.new(16,16).triangle_fill(8,0,0,8,8,16,C_RED)]
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
enemy=Enemy.new
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
  # 右のマップ
  for i in 0..15
    for j in 0..15
      Window.draw(j * 16 + 288, i * 16, block) if $map[i][j] == 1
    end
  end

  # 自分（赤の四角だけど）描画
  Window.draw(x * 16 + 288, y * 16, jibun[angle])
  enemy.move
  enemy.draw
  break if Input.keyPush?(K_ESCAPE)
end

class Bomb
    def initialize
        @bx=0
        @by=0
        @exist=false
        @time=0
        @count=0
        @bombed_x=0
        @bombed_y=0
        @img_bomb = Image.load_tiles('bomb.png', 6, 10)
        @count_bm = 0
        @bomb_ani = 0
        #@img_bomb = Image.load('data.png')
        @bombrx=0
        @bombry=0
    end
    def put(x,y,angle,bombrx,bombry)
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
            @bombrx=bombrx
            @bombry=bombry
        end
    end
    def expl
        @time+=1
        @count+=1
        if @time>180 && @exist
            @count=0
            for i in -@bombrx..@bombrx do
                for j in -@bombry..@bombry do
                    if @by+j>=0 && @bx+i>=0 && @by+j<16 && @bx+i<16
                        if $map[@by+j][@bx+i]!=1  
                            $map[@by+j][@bx+i]=4
                        end
                    end   
                end
            end
            @exist=false
            @bombed_x=@bx
            @bombed_y=@by
        end
        if @count>=30 && @bombed_x!=0
            for i in -@bombrx..@bombrx do
                for j in -@bombry..@bombry do
                    if @bombed_y+j>=0 && @bombed_x+i>=0 && @bombed_y+j<16 && @bombed_x+i<16
                        if $map[@bombed_y+j][@bombed_x+i]==4 
                            $map[@bombed_y+j][@bombed_x+i]=0
                        end  
                    end 
                end
            end
            @bombed_x=0
            @bombed_y=0
        end
    end
    def draw
        if @exist==true
            #Window.draw(@bx * 32 + 72, @by * 32, Image.new.circle_fill(@bx,@by,16,C_YELLOW))
            #Image.new.circle_fill(@bx.to_f,@by.to_f,8,C_YELLOW)
            #Image.circle_fill(@bx.to_f, @by.to_f, 8, C_YELLOW)
            
            #img_ball = Image.new(32, 32).circle_fill(16.0, 16.0, 16, C_YELLOW)
            #ball = Sprite.new(@bx *32+72, @by*32, img_ball)
            #ball.draw

            @bomb_ani = [0, 0, 1, 2, 1, 2, 1, 2, 5, 11]    
            @count_bm += 1
            ani = @bomb_ani[@count_bm / 18 % @bomb_ani.size]
            Window.draw(@bx * 32 + 72, @by * 32, @img_bomb[ani])    
            if @count_bm / 18 >= @bomb_ani.size
                @count_bm = 0
            end

            

            #Window.draw(@bx * 32 + 72, @by * 32,@img_bomb[0])
        end
    end
end
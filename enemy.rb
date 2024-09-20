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
        enemypre=Image.load_tiles('enemy.png',3,4)
        @enemy=[enemypre[9],enemypre[0],enemypre[6],enemypre[3]]
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
            if @ey==$y&&@ex==$x && @i%40
                $health-=30
            end
        end
    end

    def draw
        Window.draw(@ex * 32 + 72, @ey * 32, @enemy[@angle])
    end
end 
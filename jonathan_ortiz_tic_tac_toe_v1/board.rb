class Board
    def initialize
        @grid = Array.new(3){Array.new(3, "_")}
    end

    def valid?(position)
        return (position[0] < @grid.length) && (position[0] >= 0) && (position[1] < @grid[0].length) && (position[1] >= 0)
    end

    def empty?(position)
        return @grid[position[0]][position[1]] == "_"
    end

    def place_mark(position, mark)
        if self.valid?(position) && self.empty?(position)
            @grid[position[0]][position[1]] = mark
        else
            raise "invalid position to place a mark"
        end
    end

    def print_board
        print "["
        @grid.each_with_index do |inner, idx1|
            if idx1 > 0
                print " "
            end
            print "["
            inner.each_with_index do |elem, idx2|
                print elem
                if idx2 < inner.length-1
                    print " "
                end
            end
            print "]"
            if idx1 < @grid.length-1
                print "\n"
            end
        end
        print "]\n"
    end

    def win_row?(mark)
        @grid.each do |inner|
            streak = true
            inner.each do |elem|
                streak = false if elem != mark
            end
            return true if streak
        end
        return false
    end

    def win_col?(mark)
        row = 0
        col = 0

        while col < @grid[0].length

            #check each row value against mark for 1 col
            streak = true
            row = 0
            while row < @grid.length
                streak = false if @grid[row][col] != mark
                row += 1
            end
            return true if streak

            col += 1
        end

        #fail condition
        return false
    end

    def win_diagonal?(mark)
        row = 0
        col = 0

        #diagonal 1
        streak = true
        while row < @grid.length
            streak = false if @grid[row][row] != mark
            row += 1
        end
        return true if streak

        #diagonal 2
        row = 0
        col = @grid[0].length-1
        streak = true
        while row < @grid.length
            streak = false if @grid[row][col] != mark
            row += 1
            col -= 1
        end
        return true if streak
        return false

    end

    def win?(mark)
        return self.win_row?(mark) || self.win_col?(mark) || self.win_diagonal?(mark)
    end

    def empty_positions?
        @grid.each do |inner|
            inner.each do |elem|
                return true if elem == "_"
            end
        end
        return false
    end
end
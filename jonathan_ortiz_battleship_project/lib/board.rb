class Board
    def initialize(n)
        @grid = Array.new(n){Array.new(n, :N)}
        @size = n*n
    end

    attr_reader :size

    def [](coordinates)
        return @grid[coordinates[0]][coordinates[1]]
    end

    def []=(position, value)
        @grid[position[0]][position[1]] = value
    end

    def num_ships
        count = 0
        @grid.each do |inner|
            inner.each do |elem|
                if elem == :S
                    count += 1
                end
            end
        end
        return count
    end

    def attack(position)
        if self[position] == :S
            self[position]= :H
            puts "you sunk my battleship!"
            return true
        else
            self[position] = :X
            return false
        end
    end

    def place_random_ships
        ships = @size / 4
        while ships > 0
            x = rand(0...@grid.length)
            y = rand(0...@grid.length)
            if @grid[x][y] != :S
                @grid[x][y] = :S
                ships -= 1
            end
        end
    end

    def hidden_ships_grid
        result = []
        @grid.each do |inner|
            inner_result = []
            inner.each do |elem|
                if elem == :S
                    inner_result << :N
                else
                    inner_result << elem
                end
            end
            result << inner_result
        end
        result
    end

    def self.print_grid(grid)
        grid.each do |inner|
            inner.each_with_index do |elem, idx|
                print elem.to_s
                if idx < inner.length-1
                    print " "
                end
            end
            print "\n"
        end
    end

    def cheat
        Board.print_grid(@grid)
    end

    def print
        Board.print_grid(hidden_ships_grid)
    end

end

class HumanPlayer
    def initialize(mark_value)
        @mark = mark_value
    end

    def get_position
        puts "Enter a position as two numbers separated by a space (ex:'1 2')"
        position = gets.chomp.split(" ")
        numbers = "0123456789"
        raise "invalid position syntax" if (!numbers.include?(position[0])) || (!numbers.include?(position[1])) || (position.length > 2)
        return position.map{|elem| elem.to_i}
    end

    attr_reader :mark
end
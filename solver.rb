class Sudoku
    attr_reader :board
    def initialize(board)
        @board = board.split('')
        prepare_row_columns_boxes
        puts @rows.inspect
        puts @columns.inspect
        puts @boxes.inspect
        puts valid?
    end

    def solve!
        return false unless valid?
        return @board.join if solved?

        next_empty_index = @board.index('0')

        (1..9).each do |attempt|
            @board[next_empty_index] = attempt
            solution = Sudoku.new(@board.join).solve!
            return solution if solution
        end

        false
    end

    def valid?
        no_dups?(@rows) && no_dups?(@columns) && no_dups?(@boxes)
    end

    def solved?
        @board.count('0').zero?
    end

    private

    def prepare_row_columns_boxes
        @rows = Array.new(9) { [] }
        @columns = Array.new(9) { [] }
        @boxes = Array.new(9) { [] }

        @board.each_with_index do |value, index|
            next if value == '0'
            @rows[row_for(index)].push value
            @columns[column_for(index)].push value
            @boxes[box_for(index)].push value
        end
    end

    def row_for(index)
        index / 9
    end

    def column_for(index)
        index % 9
    end

    def box_for(index)
        box_column_co = column_for(index) / 3
        row_column_co = row_for(index) / 3
        box_column_co + (row_column_co * 3)
        # (column_for(index) / 3) + ((row_for(index) / 3) * 3)
    end

    def no_dups?(set)
        set.each do |subset|
            return false if subset.uniq.length != subset.length
        end
        true
    end
end

game = Sudoku.new('003020600900305001001806400008102900700000008006708200002609500800203009005010300')

puts game.solve!

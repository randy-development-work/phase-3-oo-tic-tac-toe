class TicTacToe
    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,4,8],
        [2,4,6],
        [0,3,6],
        [1,4,7],
        [2,5,8]
    ]

    attr_accessor :board
    def initialize
        @board = Array.new(9, " ")
    end

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(str)
        converted_str = str.to_i - 1
    end

    def move(index, token="X")
        @board[index] = token
    end

    def position_taken?(position)
        @board[position] != " "
    end


    # returns true if the move is valid and false or nil if not
    # valid move: Present on the game board, not already filled with a token.
    def valid_move?(position)
        !position_taken?(position) && position.between?(0,8)
    end

    # returns the number of turns that have been played based on the @board variable.
    def turn_count
        @board.count{|position| position != " " }
    end

    # use the #turn_count method to determine if it is "X"'s or "O"'s turn.
    def current_player 
        turn_count.even? ? "X" : "O"
    end

    # encapsulate the logic of a single complete turn composed of the following routine:

    # 1. Ask the user for their move by specifying a position between 1-9.
    # 2. Receive the user's input.
    # 3. Translate that input into an index value.
    # 4. If the move is valid, make the move and display the board.
    # 5. If the move is invalid, ask for a new move until a valid move is received.

    def turn 
        puts "Please enter a number (1-9):"
        user_input = gets.strip
        index = input_to_index(user_input)
        if valid_move?(index)
            token = current_player
            move(index, token)
        else
            turn
        end
            display_board
    end


    # return false or nil if there is no win combination present in the board and return an array containing the winning combination indexes if there is a win.
    def won?
        WIN_COMBINATIONS.any? do |combo|
            if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
              return combo
            end
          end
    end

    # return true if every element in the board contains either an "X" or an "O".
    def full?
        @board.all?{|index| index != " " }
    end

    def draw?
        full? && !won?
    end
    
    def over?
        won? || draw?
    end

    def winner
        if combo = won?
            @board[combo[0]]
        end
    end

    # allow players to take turns, checking if the game is over after every turn. 
    # At the conclusion of the game, whether because it was won or ended in a draw, the game should report to the user the outcome of the game.

    def play
        turn until over?
        puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
    end

end
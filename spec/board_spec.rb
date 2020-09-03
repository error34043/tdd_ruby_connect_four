# frozen_string_literal: true

require './lib/board.rb'

describe Board do
  subject(:board) { described_class.new }

  describe '#valid_move?' do
    context 'when move refers to an available column' do
      it 'returns true' do
        expect(board.valid_move? 1).to be true
      end
    end

    context 'when moves refers to a column with filled and available spaces' do
      before do
        board.instance_variable_set(:@board, [
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          [' XX ', '    ', '    ', '    ', '    ', '    ', '    '],
          [' XX ', '    ', '    ', '    ', '    ', '    ', '    '],
          [' XX ', '    ', '    ', '    ', '    ', '    ', '    ']
        ])
      end
      
      it 'returns true' do
        expect(board.valid_move? 1).to be true
      end
    end

    context 'when move refers to a column with no available spaces' do
      before do
        board.instance_variable_set(:@board, [
          [' XX ', '    ', '    ', '    ', '    ', '    ', '    '],
          [' XX ', '    ', '    ', '    ', '    ', '    ', '    '],
          [' XX ', '    ', '    ', '    ', '    ', '    ', '    '],
          [' XX ', '    ', '    ', '    ', '    ', '    ', '    '],
          [' XX ', '    ', '    ', '    ', '    ', '    ', '    '],
          [' XX ', '    ', '    ', '    ', '    ', '    ', '    ']
        ])
      end

      it 'returns false' do
        expect(board.valid_move? 1).to be false
      end
    end

    context 'when move refers to non-existent column' do
      it 'returns false' do
        expect(board.valid_move? 8).to be false
      end
    end

    context 'when other columns are filled' do
      before do
        board.instance_variable_set(:@board, [
          ['    ', ' XX ', '    ', '    ', '    ', '    ', ' XX '],
          [' XX ', ' XX ', '    ', ' XX ', '    ', '    ', ' XX '],
          [' XX ', ' XX ', '    ', ' XX ', ' XX ', '    ', ' XX '],
          [' XX ', ' XX ', ' XX ', ' XX ', ' XX ', '    ', ' XX '],
          [' XX ', ' XX ', ' XX ', ' XX ', ' XX ', ' XX ', ' XX '],
          [' XX ', ' XX ', ' XX ', ' XX ', ' XX ', ' XX ', ' XX ']
        ])
      end

      context 'when an almost-full column is entered' do
        it 'returns true' do
          expect(board.valid_move? 1).to be true
        end
      end

      context 'when a full column is entered' do
        it 'returns false' do
          expect(board.valid_move? 2).to be false
        end
      end
    end
  end

  describe '#add_move_to_board' do
    context 'when an invalid move is entered' do
      before do
        board.instance_variable_set(:@board, [
          [' XX ', '    ', '    ', '    ', '    ', '    ', '    '],
          [' XX ', '    ', '    ', '    ', '    ', '    ', '    '],
          [' XX ', '    ', '    ', '    ', '    ', '    ', '    '],
          [' XX ', '    ', '    ', '    ', '    ', '    ', '    '],
          [' XX ', '    ', '    ', '    ', '    ', '    ', '    '],
          [' XX ', '    ', '    ', '    ', '    ', '    ', '    ']
        ])
      end

      context 'when column is full' do
        it 'returns false' do
          expect(board.add_move_to_board(1, 'X')).to be false
        end
      end

      context 'when move entered is not in range' do
        it 'returns false' do
          expect(board.add_move_to_board(8, 'X')).to be false
        end
      end
    end

    context 'when a valid move is entered' do
      context 'when column is almost full' do
        before do
          board.instance_variable_set(:@board, [
            ['    ', ' XX ', '    ', '    ', '    ', '    ', ' XX '],
            [' XX ', ' XX ', '    ', ' XX ', '    ', '    ', ' XX '],
            [' XX ', ' XX ', '    ', ' XX ', ' XX ', '    ', ' XX '],
            [' XX ', ' XX ', ' XX ', ' XX ', ' XX ', '    ', ' XX '],
            [' XX ', ' XX ', ' XX ', ' XX ', ' XX ', ' XX ', ' XX '],
            [' XX ', ' XX ', ' XX ', ' XX ', ' XX ', ' XX ', ' XX ']
          ])
        end

        it 'returns true' do
          expect(board.add_move_to_board(1, 'X')).to be true
        end
      end

      context 'when column is empty' do
        it 'returns true' do
          expect(board.add_move_to_board(1, 'X')).to be true
        end
      end
    end
  end

  describe '#win_horizontal?' do
    context 'when 4 of the same type are next to each other in a row' do
      before do
        board.instance_variable_set(:@board, [
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', ' XX ', ' XX ', ' XX ', ' XX ', '    ', '    ']
        ])
      end

      it 'returns true' do
        expect(board.win_horizontal?).to be true
      end
    end

    context 'when 4 of the same type are not next to each other but in a row' do
      before do
        board.instance_variable_set(:@board, [
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          [' XX ', ' XX ', '    ', ' XX ', ' XX ', '    ', '    ']
        ])
      end

      it 'returns false' do
        expect(board.win_horizontal?).to be false
      end
    end

    context 'when 3 of the same type are next to each other in a row' do
      before do
        board.instance_variable_set(:@board, [
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', ' XX ', ' XX ', ' XX ', '    ', '    ']
        ])
      end

      it 'returns false' do
        expect(board.win_horizontal?).to be false
      end
    end

    context 'when 4 of same type are surrounded by other type' do
      before do
        board.instance_variable_set(:@board, [
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          [' XX ', '    ', '    ', '    ', '    ', '    ', '    '],
          [' OO ', ' OO ', ' OO ', ' XX ', ' OO ', '    ', '    '],
          [' XX ', ' XX ', ' OO ', ' XX ', ' XX ', ' XX ', ' XX '],
          [' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' OO ', ' XX '],
          [' XX ', ' XX ', ' XX ', ' OO ', ' XX ', ' OO ', ' OO ']
        ])
      end
      
      it 'returns true' do
        expect(board.win_horizontal?).to be true
      end
    end

    context 'when the board has no horizontal wins' do
      before do
        board.instance_variable_set(:@board, [
          [' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' XX ', ' OO '],
          [' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' XX ', ' OO '],
          [' OO ', ' OO ', ' OO ', ' XX ', ' OO ', ' XX ', ' OO '],
          [' XX ', ' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' XX '],
          [' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' OO ', ' XX '],
          [' XX ', ' XX ', ' XX ', ' OO ', ' XX ', ' OO ', ' OO ']
        ])
      end
      
      it 'returns false' do
        expect(board.win_horizontal?).to be false
      end
    end
  end

  describe '#win_vertical?' do
    context 'when 4 of the same type are next to each other in a column' do
      before do
        board.instance_variable_set(:@board, [
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', ' XX ', '    ', '    ', '    ', '    ', '    '],
          ['    ', ' XX ', '    ', '    ', '    ', '    ', '    '],
          ['    ', ' XX ', '    ', '    ', '    ', '    ', '    '],
          ['    ', ' XX ', '    ', '    ', '    ', '    ', '    ']
        ])
      end

      it 'returns true' do
        expect(board.win_vertical?).to be true
      end
    end

    context 'when 4 of the same type are not next to each other but in a column' do
      before do
        board.instance_variable_set(:@board, [
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', ' XX ', '    ', '    ', '    ', '    ', '    '],
          ['    ', ' OO ', '    ', '    ', '    ', '    ', '    '],
          ['    ', ' XX ', '    ', '    ', '    ', '    ', '    '],
          ['    ', ' XX ', '    ', '    ', '    ', '    ', '    '],
          ['    ', ' XX ', '    ', '    ', '    ', '    ', '    ']
        ])
      end

      it 'returns false' do
        expect(board.win_vertical?).to be false
      end
    end

    context 'when 3 of the same type are next to each other in a column' do
      before do
        board.instance_variable_set(:@board, [
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', ' OO ', '    ', '    ', '    ', '    ', '    '],
          ['    ', ' OO ', '    ', '    ', '    ', '    ', '    '],
          ['    ', ' XX ', '    ', '    ', '    ', '    ', '    '],
          ['    ', ' XX ', '    ', '    ', '    ', '    ', '    '],
          ['    ', ' XX ', '    ', '    ', '    ', '    ', '    ']
        ])
      end

      it 'returns false' do
        expect(board.win_vertical?).to be false
      end
    end

    context 'when 4 of same type are surrounded by other type' do
      before do
        board.instance_variable_set(:@board, [
          [' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' XX ', ' OO '],
          [' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' XX ', ' OO '],
          [' OO ', ' OO ', ' OO ', ' XX ', ' OO ', ' XX ', ' OO '],
          [' XX ', ' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' XX '],
          [' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' OO ', ' XX '],
          [' XX ', ' XX ', ' XX ', ' OO ', ' XX ', ' OO ', ' OO ']
        ])
      end

      it 'returns true' do
        expect(board.win_vertical?).to be true
      end
    end

    context 'when the board has no vertical wins' do
      before do
        board.instance_variable_set(:@board, [
          [' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' OO ', ' OO '],
          [' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' XX ', ' OO '],
          [' OO ', ' OO ', ' OO ', ' XX ', ' OO ', ' XX ', ' OO '],
          [' XX ', ' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' XX '],
          [' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' OO ', ' XX '],
          [' XX ', ' XX ', ' XX ', ' OO ', ' XX ', ' OO ', ' OO ']
        ])
      end

      it 'returns false' do
        expect(board.win_vertical?).to be false
      end
    end
  end

  describe '#win_diagonal?' do
    context 'when 4 of the same type are next to each other diagonally' do
      before do
        board.instance_variable_set(:@board, [
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', '    ', ' XX ', '    ', '    '],
          ['    ', '    ', '    ', ' XX ', ' OO ', '    ', '    '],
          ['    ', '    ', ' XX ', ' OO ', ' OO ', '    ', '    '],
          ['    ', ' XX ', ' OO ', ' OO ', ' OO ', '    ', '    ']
        ])
      end

      it 'returns true' do
        expect(board.win_diagonal?).to be true
      end
    end

    context 'when 4 of the same type are not next to each other but in a line' do
      before do
        board.instance_variable_set(:@board, [
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', '    ', '    ', ' XX ', '    '],
          ['    ', '    ', '    ', '    ', ' XX ', ' OO ', '    '],
          ['    ', '    ', '    ', ' OO ', ' XX ', ' OO ', '    '],
          ['    ', '    ', ' XX ', ' OO ', ' OO ', ' OO ', '    '],
          ['    ', ' XX ', ' OO ', ' OO ', ' OO ', ' OO ', '    ']
        ])
        end

      it 'returns false' do
        expect(board.win_diagonal?).to be false
      end
    end

    context 'when 3 of the same type are next to each other diagonally' do
      before do
        board.instance_variable_set(:@board, [
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', ' XX ', ' OO ', '    ', '    '],
          ['    ', '    ', ' XX ', ' OO ', ' OO ', '    ', '    '],
          ['    ', ' XX ', ' OO ', ' OO ', ' OO ', '    ', '    ']
        ])
      end

      it 'returns false' do
        expect(board.win_diagonal?).to be false
      end
    end

    context 'when 4 of same type are surrounded by other type' do
      before do
        board.instance_variable_set(:@board, [
          [' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' OO ', ' OO '],
          [' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' XX ', ' OO '],
          [' OO ', ' OO ', ' OO ', ' XX ', ' XX ', ' XX ', ' OO '],
          [' XX ', ' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' XX '],
          [' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' OO ', ' XX '],
          [' XX ', ' XX ', ' XX ', ' OO ', ' XX ', ' OO ', ' OO ']
        ])
      end

      it 'returns true' do
        expect(board.win_diagonal?).to be true
      end
    end

    context 'when the board has no vertical wins' do
      before do
        board.instance_variable_set(:@board, [
          [' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' OO ', ' OO '],
          [' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' XX ', ' OO '],
          [' OO ', ' OO ', ' OO ', ' XX ', ' OO ', ' XX ', ' OO '],
          [' XX ', ' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' XX '],
          [' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' OO ', ' XX '],
          [' XX ', ' XX ', ' XX ', ' OO ', ' XX ', ' OO ', ' OO ']
        ])
      end

      it 'returns false' do
        expect(board.win_diagonal?).to be false
      end
    end
  end

  describe '#filled_up?' do
    context 'when the board is empty' do
      before do
        board.instance_variable_set(:@board, [
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', '    ', '    ', '    ', '    ']
        ])
      end

      it 'returns false' do
        expect(board.filled_up?).to be false
      end
    end

    context 'when the board has empty spaces' do
      before do
        board.instance_variable_set(:@board, [
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', ' XX ', ' OO ', '    ', '    '],
          ['    ', '    ', ' XX ', ' OO ', ' OO ', '    ', '    '],
          ['    ', ' XX ', ' OO ', ' OO ', ' OO ', '    ', '    ']
        ])
      end

      it 'returns false' do
        expect(board.filled_up?).to be false
      end
    end

    context 'when the board is full' do
      before do
        board.instance_variable_set(:@board, [
          [' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' OO ', ' OO '],
          [' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' XX ', ' OO '],
          [' OO ', ' OO ', ' OO ', ' XX ', ' OO ', ' XX ', ' OO '],
          [' XX ', ' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' XX '],
          [' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' OO ', ' XX '],
          [' XX ', ' XX ', ' XX ', ' OO ', ' XX ', ' OO ', ' OO ']
        ])
      end

      it 'returns true' do
        expect(board.filled_up?).to be true
      end
    end
  end

  describe "#victory?" do
    context "when there's a horizontal win" do
      before do
        board.instance_variable_set(:@board, [
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          [' XX ', '    ', '    ', '    ', '    ', '    ', '    '],
          [' OO ', ' OO ', ' OO ', ' XX ', ' OO ', '    ', '    '],
          [' XX ', ' XX ', ' OO ', ' XX ', ' XX ', ' XX ', ' XX '],
          [' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' OO ', ' XX '],
          [' XX ', ' XX ', ' XX ', ' OO ', ' XX ', ' OO ', ' OO ']
        ])
      end

      it 'returns true' do
        expect(board.victory?).to be true
      end
    end

    context "when there's a vertical win" do
      before do
        board.instance_variable_set(:@board, [
          [' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' OO ', ' OO '],
          [' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' XX ', ' OO '],
          [' OO ', ' OO ', ' OO ', ' XX ', ' XX ', ' XX ', ' OO '],
          [' XX ', ' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' XX '],
          [' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' OO ', ' XX '],
          [' XX ', ' XX ', ' XX ', ' OO ', ' XX ', ' OO ', ' OO ']
        ])
      end

      it 'returns true' do
        expect(board.victory?).to be true
      end
    end

    context "when there's a diagonal win" do
      before do
        board.instance_variable_set(:@board, [
          [' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' OO ', ' OO '],
          [' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' XX ', ' OO '],
          [' OO ', ' OO ', ' OO ', ' XX ', ' XX ', ' XX ', ' OO '],
          [' XX ', ' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' XX '],
          [' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' OO ', ' XX '],
          [' XX ', ' XX ', ' XX ', ' OO ', ' XX ', ' OO ', ' OO ']
        ])
      end

      it 'returns true' do
        expect(board.victory?).to be true
      end
    end

    context "when there's no win and board is not full" do
      before do
        board.instance_variable_set(:@board, [
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', '    ', '    ', '    ', '    '],
          ['    ', '    ', '    ', ' XX ', ' OO ', '    ', '    '],
          ['    ', '    ', ' XX ', ' OO ', ' OO ', '    ', '    '],
          ['    ', ' XX ', ' OO ', ' OO ', ' OO ', '    ', '    ']
        ])
      end

      it 'returns false' do
        expect(board.victory?).to be false
      end
    end

    context "when there's no win and board is full" do
      before do
        board.instance_variable_set(:@board, [
          [' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' OO ', ' OO '],
          [' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' XX ', ' OO '],
          [' OO ', ' OO ', ' OO ', ' XX ', ' OO ', ' XX ', ' OO '],
          [' XX ', ' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' XX '],
          [' XX ', ' OO ', ' XX ', ' OO ', ' XX ', ' OO ', ' XX '],
          [' XX ', ' XX ', ' XX ', ' OO ', ' XX ', ' OO ', ' OO ']
        ])
      end

      it 'returns false' do
        expect(board.victory?).to be false
      end
    end
  end
end
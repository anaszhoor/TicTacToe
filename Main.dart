import 'dart:io';

void main() {
  // Initialize the Tic Tac Toe board
  List<List<String>> board = List.generate(3, (_) => List.generate(3, (_) => ' '));

  // Player 1 and Player 2 symbols
  String player1 = 'X';
  String player2 = 'O';

  // Variable to track the current player
  String currentPlayer = player1;

  // Play the game until there's a winner or a tie
  while (true) {
    // Display the current state of the board
    printBoard(board);

    // Get the player's move
    print('\n$currentPlayer\'s turn. Enter row (0-2) and column (0-2) separated by a space:');
    String input = stdin.readLineSync() ?? '';
    List<int> move = input.split(' ').map((e) => int.parse(e)).toList();

    // Check if the move is valid
    if (isValidMove(move, board)) {
      // Make the move
      board[move[0]][move[1]] = currentPlayer;

      // Check for a winner
      if (isWinner(board, currentPlayer)) {
        printBoard(board);
        print('$currentPlayer wins!');
        break;
      }

      // Check for a tie
      if (isBoardFull(board)) {
        printBoard(board);
        print('It\'s a tie!');
        break;
      }

      // Switch to the other player
      currentPlayer = (currentPlayer == player1) ? player2 : player1;
    } else {
      print('Invalid move. Try again.');
    }
  }
}

// Function to print the Tic Tac Toe board
void printBoard(List<List<String>> board) {
  print('\n  0   1   2');
  print('-------------');
  for (int i = 0; i < 3; i++) {
    print('$i| ${board[i][0]} | ${board[i][1]} | ${board[i][2]} |');
    print('-------------');
  }
}

// Function to check if a move is valid
bool isValidMove(List<int> move, List<List<String>> board) {
  if (move.length == 2 && move[0] >= 0 && move[0] < 3 && move[1] >= 0 && move[1] < 3) {
    return board[move[0]][move[1]] == ' ';
  }
  return false;
}

// Function to check if a player has won
bool isWinner(List<List<String>> board, String player) {
  // Check rows and columns
  for (int i = 0; i < 3; i++) {
    if ((board[i][0] == player && board[i][1] == player && board[i][2] == player) ||
        (board[0][i] == player && board[1][i] == player && board[2][i] == player)) {
      return true;
    }
  }

  // Check diagonals
  if ((board[0][0] == player && board[1][1] == player && board[2][2] == player) ||
      (board[0][2] == player && board[1][1] == player && board[2][0] == player)) {
    return true;
  }

  return false;
}

// Function to check if the board is full
bool isBoardFull(List<List<String>> board) {
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (board[i][j] == ' ') {
        return false;
      }
    }
  }
  return true;
}
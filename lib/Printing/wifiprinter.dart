import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:pms/ComponentsAndConstants/flags.dart';

class WifiPrinter {
  void wifiPrint() async {
    print("WIFI CALLED");
    final PrinterNetworkManager printerManager = PrinterNetworkManager();
    printerManager.selectPrinter(host, port: 9100);

    final PosPrintResult res =
        await printerManager.printTicket(await testTicket());
    print('Print result: ${res.msg}');
  }

  Future<Ticket> testTicket() async {
    final Ticket ticket = Ticket(PaperSize.mm80);

    ticket.text(
        'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
    ticket.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
        styles: PosStyles(codeTable: PosCodeTable.westEur));
    ticket.text('Special 2: blåbærgrød',
        styles: PosStyles(codeTable: PosCodeTable.westEur));

    ticket.text('Bold text', styles: PosStyles(bold: true));
    ticket.text('Reverse text', styles: PosStyles(reverse: true));
    ticket.text('Underlined text',
        styles: PosStyles(underline: true), linesAfter: 1);
    ticket.text('Align left', styles: PosStyles(align: PosTextAlign.left));
    ticket.text('Align center', styles: PosStyles(align: PosTextAlign.center));
    ticket.text('Align right',
        styles: PosStyles(align: PosTextAlign.right), linesAfter: 1);

    ticket.row([
      PosColumn(
        text: 'col3',
        width: 3,
        styles: PosStyles(align: PosTextAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col6',
        width: 6,
        styles: PosStyles(align: PosTextAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col3',
        width: 3,
        styles: PosStyles(align: PosTextAlign.center, underline: true),
      ),
    ]);

    ticket.text('Text size 200%',
        styles: PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));

    final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    ticket.barcode(Barcode.upcA(barData));
    ticket.feed(2);
    ticket.cut();
    return ticket;
  }
}

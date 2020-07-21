import 'package:notustohtml/notustohtml.dart';
import 'package:p7app/main_app/views/widgets/custom_rich_text_from_field.dart';
import 'package:quill_delta/quill_delta.dart';

class ZeyfrHelper {
  static NotusDocument htmlToNotusDocument(String htmlString) {
    final converter = NotusHtmlCodec();
    Delta delta = converter.decode(htmlString??""); // Zefyr compatible Delta
    NotusDocument document = NotusDocument.fromDelta(delta); //
    return document;
  }

  static String notusDocumentToHTML(NotusDocument notusDocument) {
    final converter = NotusHtmlCodec();

    String html = converter.encode(notusDocument.toDelta());
    return html;
  }
}

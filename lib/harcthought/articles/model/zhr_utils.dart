import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:harcapp_core/comm_classes/dio.dart';
import 'package:harcapp_core/comm_classes/storage.dart';
import 'package:harcapp_core/harcthought/articles/model/article_source.dart';
import 'package:html/dom.dart' as html_dom;
import 'package:html/parser.dart';
import 'package:rss_dart/domain/atom_item.dart';
import 'package:image/image.dart' as img;

import 'article_data.dart';
import 'common.dart';


abstract class ZHRUtils{

  static List<ArticleElement>? _nodeToArticleElement(var node){

    if(node is html_dom.Comment) {
      if(node.data == null || node.data!.replaceAll('\n', '').isEmpty) return null;
      return [ParagraphArticleElement(text: node.data!)];
    }

    else if(node is html_dom.Text) {
      if(node.text.replaceAll('\n', '').isEmpty) return null;
      return [ParagraphArticleElement(text: node.text)];

    } else if(node is html_dom.Element) {
      if (node.localName == 'p') {
        if(node.text.replaceAll('\n', '').isEmpty) return null;
        return [ParagraphArticleElement(text: node.text)];

      }else if (node.localName!.startsWith('h')) {
        if(node.text.isEmpty) return null;
        return [HeaderArticleElement(text: node.text)];

      }else if (node.localName == 'ul') {

        List<ListItemArticleElement> result = [];
        for(var subNode in node.nodes){
          if(subNode is! html_dom.Element) continue;
          if(subNode.localName != 'li') continue;
          if(subNode.text.replaceAll('\n', '').isEmpty) continue;
          result.add(ListItemArticleElement(index: null, text: subNode.text));
        }
        return result;

      }else if (node.localName == 'ol') {

        int index = int.tryParse(node.attributes['start']??'')??1;

        List<ListItemArticleElement> result = [];
        for(var subNode in node.nodes){
          if(subNode is! html_dom.Element) continue;
          if(subNode.localName != 'li') continue;
          if(subNode.text.replaceAll('\n', '').isEmpty) continue;
          result.add(ListItemArticleElement(index: index++, text: subNode.text));
        }
        return result;

      }else if (node.localName == 'div' && node.attributes['class'] == 'wp-block-image') {

        var figureNode = node.nodes.firstWhere((subNode) =>
        subNode is html_dom.Element && subNode.localName == 'figure');

        String? imageLink;
        String? desc;
        for (var subNode in figureNode.nodes) {
          subNode as html_dom.Element;
          if (subNode.localName == 'img') imageLink = subNode.attributes['src'];
          if (subNode.localName == 'figcaption') desc = subNode.text;
        }

        if (imageLink != null)
          return [PictureArticleElement(link: imageLink, desc: desc)];
        else
          return null;

      } else
        return [CustomArticleElement(html: node.outerHtml)];

    } else
      return null;

  }

  static String? linkFromAtom(AtomItem item) => item.links[0].href;

  static ArticleData fromAtomItem(ArticleSource source, AtomItem item, {String? imageUrl}){

    List<String> tags = item.categories.map((cat) => '#${cat.term!.toUpperCase()}').toList();

    String text = item.content!.replaceAll('<br>', '\n');

    var nodes = parse(text).nodes[0].nodes[1].nodes;
    nodes.removeWhere((node) => node is html_dom.Text && node.text.replaceAll('\n', '').isEmpty);

    try {
      // Remove "pobierz PDF"
      nodes.removeAt(0);

      // Remove "artykuł pobrano z ..."
      nodes.removeLast();
    }catch(e){}

    List<ArticleElement> artElements = [];
    for(var node in nodes){
      List<ArticleElement>? elements = _nodeToArticleElement(node);
      if(elements != null)
        artElements.addAll(elements);
    }

    String localId = item.id!.split("?p=")[1];

    return ArticleData(
      source,
      localId,
      title: item.title??(throw Exception('No title in atom item')),
      tags: tags,
      author: item.authors[0].name??(throw Exception('No author name in atom item')),
      date: DateTime.tryParse(item.published!)??(throw Exception('No publish date in atom item')),
      link: linkFromAtom(item)??(throw Exception('No link in atom item')),
      imageUrl: imageUrl,
      articleElements: artElements,
    );
  }

  static Future<String> coverLinkFromHtmlLink(String link) async {
    String? htmlFile = await downloadFile(link, webCors: true);
    if(htmlFile == null) return '';
    String imageLink = htmlFile.split('<meta property="og:image" content="')[1];
    imageLink = imageLink.split('" />')[0];
    imageLink = imageLink.split('"/>')[0];
    return imageLink;
  }

  static Future<(img.Image?, img.Image?)> _coverFromHtmlLink(String link) async{
    try{
      String imageLink = await coverLinkFromHtmlLink(link);

      Response response = await defDio.get(webCorsProxy(imageLink), options: Options(responseType: ResponseType.bytes));
      img.Image image = img.decodeImage(response.data)!;

      img.Image bigImage = img.copyResize(image, width: 1000, interpolation: img.Interpolation.cubic);
      img.Image smallImage = img.copyResize(image, width: 480);
      return (bigImage, smallImage);
    }catch(_){
      return (null, null);
    }
  }

  static Future<(img.Image?, img.Image?)> downloadCover(String link) async {
    return await compute(_coverFromHtmlLink, link);
  }

}

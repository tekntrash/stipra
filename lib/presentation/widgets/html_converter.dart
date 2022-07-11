/*
 * Modified work: Copyright 2020 Ali Ahamed Thowfeek
 * Original work: Copyright 2019 Ashraff Hathibelagal
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:html_unescape/html_unescape.dart';

import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';

/// This class is the only class you should be using from the
/// simple_html_css package. It contains all the methods you need to
/// handle your HTML and CSS.
class HTMLConverter {
  /// Returns a [TextSpan] object you can directly pass to a [RichText]
  /// widget. In addition to the build context and your HTML content, you can
  /// pass a function to this method. You can use the function to handle
  /// click events on anchor tags. The function will receive the actual link
  /// as its argument.
  ///
  /// To apply a default text style which affects all of the content
  /// (unless they are overridden) pass in [defaultTextStyle]
  /// ```dart
  /// HTML.toTextSpan(
  ///   context,
  ///   htmlContent,
  ///   defaultTextStyle: TextStyle(color: Colors.grey[700]),
  /// );
  /// ```
  ///
  /// To overrides and/or apply custom styles to html tags
  /// pass in [overrideStyle] which is a [Map] of [String],[TextStyle]
  /// where [String] is the html tag, and [TextStyle] is the style applied
  /// ```dart
  /// HTML.toTextSpan(
  ///   context,
  ///   htmlContent,
  ///   overrideStyle: {
  ///     "p": TextStyle(color: Colors.red),
  ///     "a": TextStyle(decoration: TextDecoration.underline),
  ///     //...
  ///     //...
  ///   },
  /// );
  /// ```

  static TextSpan toTextSpan(BuildContext context, String htmlContent,
      {Function(dynamic)? linksCallback,
      Map<String, TextStyle>? overrideStyle,
      TextStyle? defaultTextStyle}) {
    //to fix a known issue with &nbsp; when appearing after an ending tag
    htmlContent =
        htmlContent.replaceAll("&nbsp;", " ").replaceAll("&nbsp", " ");

    //to fix a known issue with non self closing <br> tags
    htmlContent = htmlContent.replaceAll("<br>", "<br />");
    //htmlContent = htmlContent.replaceAll("</ p>", "</p>");
    //[<]+/+[a-zA-Z0-9.-/ ]+[>]

    final regexp = RegExp('[<]+/+[a-zA-Z0-9.-/ ]+[>]');
    final lastHTML = htmlContent;
    for (Match m in regexp.allMatches(lastHTML)) {
      htmlContent = htmlContent.replaceAll(m[0]!, m[0]!.replaceAll(" ", ""));
    }

    Parser p = Parser(context, HtmlUnescape().convert(htmlContent),
        linksCallback: linksCallback,
        overrideStyleMap: overrideStyle ?? Map<String, TextStyle>(),
        defaultTextStyle: defaultTextStyle);

    var list = <TextSpan>[];
    try {
      list = p.parse();
    } catch (e, s) {
      print('simple_html_css Exception: $e');
      print('simple_html_css Stack Trace: $s');
    }

    return TextSpan(text: "", children: list);
  }

  /// Returns a [RichText] widget you can directly add to your widget tree.
  /// In addition to the build context and your HTML content, you can
  /// pass a function to this method. You can use the function to handle
  /// click events on anchor tags. The function will receive the actual link
  /// as its argument.
  ///
  /// To apply a default text style which affects all of the content
  /// (unless they are overridden) pass in [defaultTextStyle]
  /// ```dart
  /// HTML.toRichText(
  ///   context,
  ///   htmlContent,
  ///   defaultTextStyle: TextStyle(color: Colors.grey[700]),
  /// );
  /// ```
  ///
  /// To overrides and/or apply custom styles to html tags
  /// pass in [overrideStyle] which is a [Map] of [String],[TextStyle]
  /// where [String] is the html tag, and [TextStyle] is the style applied
  /// ```dart
  /// HTML.toRichText(
  ///   context,
  ///   htmlContent,
  ///   overrideStyle: {
  ///     "p": TextStyle(color: Colors.red),
  ///     "a": TextStyle(decoration: TextDecoration.underline),
  ///     //...
  ///     //...
  ///   },
  /// );
  /// ```

  static RichText toRichText(
    BuildContext context,
    String htmlContent, {
    Function(dynamic)? linksCallback,
    Map<String, TextStyle>? overrideStyle,
    TextStyle? defaultTextStyle,
    TextAlign textAlign = TextAlign.center,
    int? maxLines,
  }) {
    return RichText(
      text: toTextSpan(context, htmlContent,
          linksCallback: linksCallback,
          overrideStyle: overrideStyle ?? {},
          defaultTextStyle:
              defaultTextStyle ?? TextStyle(color: Colors.grey[700])),
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}

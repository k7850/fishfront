import 'package:fishfront/_core/utils/validator_util.dart';
import 'package:fishfront/data/dto/comment_request_dto.dart';
import 'package:fishfront/ui/board/board_detail_page/board_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class boardDetailWriteComment extends ConsumerStatefulWidget {
  boardDetailWriteComment({
    super.key,
  });

  @override
  ConsumerState<boardDetailWriteComment> createState() => _boardDetailWriteCommentState();
}

class _boardDetailWriteCommentState extends ConsumerState<boardDetailWriteComment> {
  final _formKey = GlobalKey<FormState>();

  final _controller = TextEditingController();

  FocusNode focusNode = new FocusNode();
  String msg = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        // key: _formKey,
        decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.grey, width: 1))),
        padding: const EdgeInsets.only(left: 20),
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Text(msg, style: const TextStyle(color: Colors.red, fontSize: 11)),
                  TextFormField(
                    controller: _controller,
                    validator: (value) {
                      print(validateContent()(value));
                      msg = validateContent()(value) ?? "";
                      setState(() {});
                      return;
                    },
                    focusNode: focusNode,
                    // autofocus: true,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      hintText: "댓글을 남겨주세요.",
                      // isDense: true,
                      // labelText: "",
                      // filled: true,
                      // fillColor: Colors.grey,
                      // prefixIcon: Icon(Icons.search, size: 30),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                if (_formKey.currentState!.validate() && msg == "") {
                  print("댓글입력${_controller.text}");
                  CommentRequestDTO commentRequestDTO = new CommentRequestDTO(text: _controller.text);
                  focusNode.unfocus();
                  _controller.clear();
                  ref.read(boardDetailProvider.notifier).notifyCommentCreate(commentRequestDTO);
                }
              },
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: const Center(child: Text(" 등록", style: TextStyle(color: Colors.blue))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

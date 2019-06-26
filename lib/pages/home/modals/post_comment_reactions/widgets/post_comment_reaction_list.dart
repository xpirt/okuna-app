import 'package:Openbook/models/emoji.dart';
import 'package:Openbook/models/post.dart';
import 'package:Openbook/models/post_comment.dart';
import 'package:Openbook/models/post_comment_reaction.dart';
import 'package:Openbook/models/post_comment_reaction_list.dart';
import 'package:Openbook/provider.dart';
import 'package:Openbook/services/navigation_service.dart';
import 'package:Openbook/services/user.dart';
import 'package:Openbook/widgets/http_list.dart';
import 'package:Openbook/widgets/tiles/post_comment_reaction_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OBPostCommentReactionList extends StatefulWidget {
  // The emoji to show reactions of
  final Emoji emoji;

  // The postComment to show reactions of
  final PostComment postComment;

  final Post post;

  const OBPostCommentReactionList(
      {Key key,
      @required this.emoji,
      @required this.postComment,
      @required this.post})
      : super(key: key);

  @override
  OBPostCommentReactionListState createState() {
    return OBPostCommentReactionListState();
  }
}

class OBPostCommentReactionListState extends State<OBPostCommentReactionList> {
  UserService _userService;
  NavigationService _navigationService;

  bool _needsBootstrap;

  OBHttpListController _httpListController;

  @override
  void initState() {
    super.initState();
    _needsBootstrap = true;
    _httpListController = OBHttpListController();
  }

  @override
  Widget build(BuildContext context) {
    if (_needsBootstrap) {
      var provider = OpenbookProvider.of(context);
      _userService = provider.userService;
      _navigationService = provider.navigationService;
      _needsBootstrap = false;
    }

    return OBHttpList<PostCommentReaction>(
      controller: _httpListController,
      listItemBuilder: _buildPostCommentReactionListItem,
      searchResultListItemBuilder: _buildPostCommentReactionListItem,
      listRefresher: _refreshPostCommentReactions,
      listOnScrollLoader: _loadMorePostCommentReactions,
      resourceSingularName: 'comment reaction',
      resourcePluralName: 'comment reactions',
    );
  }

  Widget _buildPostCommentReactionListItem(
      BuildContext context, PostCommentReaction postCommentReaction) {
    return OBPostCommentReactionTile(
      postCommentReaction: postCommentReaction,
      onPostCommentReactionTilePressed: _onPostCommentReactionListItemPressed,
    );
  }

  void _onPostCommentReactionListItemPressed(
      PostCommentReaction postCommentReaction) {
    _navigationService.navigateToUserProfile(
        user: postCommentReaction.reactor, context: context);
  }

  Future<List<PostCommentReaction>> _refreshPostCommentReactions() async {
    PostCommentReactionList postCommentReactions =
        await _userService.getReactionsForPostComment(
            post: widget.post, postComment: widget.postComment);
    return postCommentReactions.reactions;
  }

  Future<List<PostCommentReaction>> _loadMorePostCommentReactions(
      List<PostCommentReaction> postCommentReactionsList) async {
    PostCommentReaction lastPostCommentReaction = postCommentReactionsList.last;
    int lastPostCommentReactionId = lastPostCommentReaction.id;
    List<PostCommentReaction> morePostCommentReactions =
        (await _userService.getReactionsForPostComment(
      post: widget.post,
      postComment: widget.postComment,
      maxId: lastPostCommentReactionId,
      count: 20,
    ))
            .reactions;
    return morePostCommentReactions;
  }
}

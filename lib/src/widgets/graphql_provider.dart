import 'package:flutter/widgets.dart';

import 'package:graphql_flutter/src/graphql_client.dart';

class GraphQLProvider extends StatefulWidget {
  const GraphQLProvider({
    Key key,
    this.client,
    this.child,
  }) : super(key: key);

  final ValueNotifier<GraphQLClient> client;
  final Widget child;

  static ValueNotifier<GraphQLClient> of(BuildContext context) {
    final _InheritedGraphQLProvider inheritedGraphqlProvider =
        context.inheritFromWidgetOfExactType(_InheritedGraphQLProvider);

    return inheritedGraphqlProvider.client;
  }

  @override
  State<StatefulWidget> createState() => _GraphQLProviderState();
}

class _GraphQLProviderState extends State<GraphQLProvider> {
  void didValueChange() => setState(() {});

  @override
  void initState() {
    super.initState();

    widget.client.addListener(didValueChange);
  }

  @override
  void dispose() {
    widget.client?.removeListener(didValueChange);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedGraphQLProvider(
      client: widget.client,
      child: widget.child,
    );
  }
}

class _InheritedGraphQLProvider extends InheritedWidget {
  _InheritedGraphQLProvider({
    this.client,
    Widget child,
  })  : clientValue = client.value,
        super(child: child);

  final ValueNotifier<GraphQLClient> client;
  final GraphQLClient clientValue;

  @override
  bool updateShouldNotify(_InheritedGraphQLProvider oldWidget) {
    return clientValue != oldWidget.clientValue;
  }
}

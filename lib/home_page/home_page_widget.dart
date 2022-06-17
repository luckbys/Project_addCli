import '../adicionar/adicionar_widget.dart';
import '../backend/backend.dart';
import '../editar/editar_widget.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text_search/text_search.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with TickerProviderStateMixin {
  List<ClienteRecord> simpleSearchResults = [];
  TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final animationsMap = {
    'buttonOnActionTriggerAnimation': AnimationInfo(
      curve: Curves.linear,
      trigger: AnimationTrigger.onActionTrigger,
      duration: 600,
      initialState: AnimationState(
        offset: Offset(2, 2),
        scale: 1,
        opacity: 0,
      ),
      finalState: AnimationState(
        offset: Offset(0, 0),
        scale: 1,
        opacity: 1,
      ),
    ),
  };

  @override
  void initState() {
    super.initState();
    setupTriggerAnimations(
      animationsMap.values
          .where((anim) => anim.trigger == AnimationTrigger.onActionTrigger),
      this,
    );

    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 25),
          child: Text(
            'Clientes',
            style: FlutterFlowTheme.of(context).title2.override(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 22,
                ),
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
      ),
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdicionarWidget(),
            ),
          );
        },
        backgroundColor: Color(0xFF20559C),
        elevation: 8,
        child: Icon(
          Icons.add,
          color: Colors.black,
          size: 24,
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 50, 16, 24),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: AlignmentDirectional(0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                          child: TextFormField(
                            controller: textController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'pesquisar',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .bodyText2
                                  .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF7C8791),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 0,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 0,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF090F13),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            await queryClienteRecordOnce()
                                .then(
                                  (records) => simpleSearchResults = TextSearch(
                                    records
                                        .map(
                                          (record) => TextSearchItem(
                                              record, [record.nome]),
                                        )
                                        .toList(),
                                  )
                                      .search(textController.text)
                                      .map((r) => r.object)
                                      .toList(),
                                )
                                .onError((_, __) => simpleSearchResults = [])
                                .whenComplete(() => setState(() {}));

                            setState(() => FFAppState().listafull = false);
                            await (animationsMap[
                                        'buttonOnActionTriggerAnimation']
                                    .curvedAnimation
                                    .parent as AnimationController)
                                .forward(from: 0.0);
                          },
                          text: '',
                          icon: Icon(
                            Icons.search,
                            color: Color(0xFF1A9AE3),
                            size: 15,
                          ),
                          options: FFButtonOptions(
                            width: 50,
                            height: 40,
                            color: FlutterFlowTheme.of(context).primaryBtnText,
                            textStyle:
                                FlutterFlowTheme.of(context).subtitle2.override(
                                      fontFamily: 'Outfit',
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                            elevation: 2,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: 50,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            setState(() => FFAppState().listafull = true);
                            setState(() {
                              textController?.clear();
                            });
                            await (animationsMap[
                                        'buttonOnActionTriggerAnimation']
                                    .curvedAnimation
                                    .parent as AnimationController)
                                .forward(from: 0.0);
                          },
                          text: '',
                          icon: Icon(
                            Icons.close,
                            color: Color(0xFFD02F09),
                            size: 15,
                          ),
                          options: FFButtonOptions(
                            width: 50,
                            height: 40,
                            color: FlutterFlowTheme.of(context).primaryBtnText,
                            textStyle:
                                FlutterFlowTheme.of(context).subtitle2.override(
                                      fontFamily: 'Outfit',
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                            elevation: 2,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: 50,
                          ),
                          showLoadingIndicator: false,
                        ).animated(
                            [animationsMap['buttonOnActionTriggerAnimation']]),
                      ),
                    ],
                  ),
                ),
              ),
              if (FFAppState().listafull ?? true)
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    child: StreamBuilder<List<ClienteRecord>>(
                      stream: queryClienteRecord(),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: SpinKitFadingFour(
                                color: Color(0x00DBE2E7),
                                size: 50,
                              ),
                            ),
                          );
                        }
                        List<ClienteRecord> listViewClienteRecordList =
                            snapshot.data;
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: listViewClienteRecordList.length,
                          itemBuilder: (context, listViewIndex) {
                            final listViewClienteRecord =
                                listViewClienteRecordList[listViewIndex];
                            return Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 1, 12),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Color(0xFF00164D),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 3,
                                      color: Color(0xFF42A5F5),
                                      offset: Offset(1, 1),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: Color(0xFF42A5F5),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 10, 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5, 5, 5, 5),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              listViewClienteRecord.nome,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryBtnText,
                                                      ),
                                            ),
                                            Text(
                                              listViewClienteRecord.telefone,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .lineColor,
                                                      ),
                                            ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  -0.05, 0),
                                              child: FlutterFlowIconButton(
                                                borderColor: Colors.transparent,
                                                borderRadius: 30,
                                                borderWidth: 1,
                                                buttonSize: 60,
                                                fillColor: Color(0xFF00164D),
                                                icon: Icon(
                                                  Icons.delete_outlined,
                                                  color: Color(0xFFD02F09),
                                                  size: 15,
                                                ),
                                                onPressed: () async {
                                                  await listViewClienteRecord
                                                      .reference
                                                      .delete();
                                                },
                                              ),
                                            ),
                                            FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30,
                                              borderWidth: 1,
                                              buttonSize: 60,
                                              icon: Icon(
                                                Icons.edit,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBtnText,
                                                size: 15,
                                              ),
                                              onPressed: () async {
                                                await Navigator
                                                    .pushAndRemoveUntil(
                                                  context,
                                                  PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    duration: Duration(
                                                        milliseconds: 0),
                                                    reverseDuration: Duration(
                                                        milliseconds: 0),
                                                    child: EditarWidget(
                                                      cliente:
                                                          listViewClienteRecord
                                                              .reference,
                                                    ),
                                                  ),
                                                  (r) => false,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              if (!(FFAppState().listafull) ?? true)
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    child: Builder(
                      builder: (context) {
                        final clinames = simpleSearchResults?.toList() ?? [];
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: clinames.length,
                          itemBuilder: (context, clinamesIndex) {
                            final clinamesItem = clinames[clinamesIndex];
                            return Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 1, 12),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Color(0xFF00164D),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 3,
                                      color: Color(0xFF42A5F5),
                                      offset: Offset(1, 1),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: Color(0xFF42A5F5),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 10, 10, 10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            5, 5, 5, 5),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              clinamesItem.nome,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryBtnText,
                                                      ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(50, 0, 0, 0),
                                              child: FlutterFlowIconButton(
                                                borderColor: Colors.transparent,
                                                borderRadius: 30,
                                                borderWidth: 1,
                                                buttonSize: 60,
                                                fillColor: Color(0xFF00164D),
                                                icon: Icon(
                                                  Icons.delete_outlined,
                                                  color: Color(0xFFD02F09),
                                                  size: 15,
                                                ),
                                                onPressed: () async {
                                                  await clinamesItem.reference
                                                      .delete();
                                                },
                                              ),
                                            ),
                                            FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 30,
                                              borderWidth: 1,
                                              buttonSize: 60,
                                              icon: Icon(
                                                Icons.edit,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBtnText,
                                                size: 15,
                                              ),
                                              onPressed: () async {
                                                await Navigator
                                                    .pushAndRemoveUntil(
                                                  context,
                                                  PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    duration: Duration(
                                                        milliseconds: 0),
                                                    reverseDuration: Duration(
                                                        milliseconds: 0),
                                                    child: EditarWidget(),
                                                  ),
                                                  (r) => false,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

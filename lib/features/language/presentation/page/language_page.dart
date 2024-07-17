part of language;

class LanguagePage extends StatefulWidget {
  static const String route = "/language";

  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  late final LanguageCubit _cubit;
  final listLanguage = [
    const LanguageEntity(
        languageCode: "en", languageName: R.english, icon: AppPath.icEngland),
    const LanguageEntity(
        languageCode: "vi", languageName: R.vietnamese, icon: AppPath.icVietNam)
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit = LanguageCubit();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>_cubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(R.language.tr()),
          centerTitle: true,
          actions: [
            BlocBuilder<LanguageCubit, String>(
              builder: (context, state) {
                return IconButton(
                    onPressed: () {
                      _cubit.saveLang();
                      context.setLocale(Locale(state));
                      NavigationUtil.pop();
                    },
                    icon: Icon(Icons.check));
              },
            )
          ],
        ),
        body: Column(
          children: [
            //
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                    horizontal: 21, vertical: 24),
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemCount: listLanguage.length,
                itemBuilder: (ctx, index) {
                  return BlocBuilder<LanguageCubit, String>(
                    builder: (context, state) {
                      print(state);
                      return LanguageItem(
                        isSelected: listLanguage[index].languageCode == state,
                        language: listLanguage[index],
                        onTap: () {
                          _cubit.selectCurrentLang(
                              listLanguage[index].languageCode);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

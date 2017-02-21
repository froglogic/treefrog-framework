win32 {
  INCLUDEPATH += $$quote($$(TFDIR)\\include)
  LIBS += -L$$quote($$(TFDIR)\\bin)
  CONFIG(debug, debug|release) {
    LIBS += -ltreefrogd1
  } else {
    LIBS += -ltreefrog1
  }
} else {
  unix:QMAKE_RPATHDIR += $ORIGIN/../lib
  unix:LIBS += -L/usr/lib -ltreefrog
  unix:INCLUDEPATH += /usr/include/treefrog

  # c++11
  lessThan(QT_MAJOR_VERSION, 5) {
    QMAKE_CXXFLAGS += -std=c++0x
  }
}

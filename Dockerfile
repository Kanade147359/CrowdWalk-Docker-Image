FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 基本・GL(software)系・ロケール
RUN apt-get update && \
    apt-get install -y \
      git vim wget gnupg x11-apps software-properties-common locales \
      libgl1-mesa-dri libgl1 libglu1-mesa mesa-utils libosmesa6 \
      libxext6 libxrender1 libxtst6 libxi6 && \
    add-apt-repository -y ppa:openjdk-r/ppa && \
    apt-get update && \
    apt-get install -y \
    openjdk-17-jdk openjfx \
    fonts-noto-cjk language-pack-ja && \
    locale-gen ja_JP.UTF-8 && \
    update-locale LANG=ja_JP.UTF-8 && \
    \
    # CrowdWalk 取得とビルド
    git clone https://github.com/crest-cassia/CrowdWalk.git && \
    cd CrowdWalk/crowdwalk && \
    ./gradlew && \
    \
    # quickstart.sh を JavaFX 明示 + 外部からのオプション取り込みに修正
    sed -i 's|^JAVAOPT=.*|JAVAOPT="-Dfile.encoding=UTF-8 $JAVA_OPTS $PRISM_OPTS $AWT_OPTS"|' quickstart.sh && \
    sed -i '/^JAR=\$DIR\/build\/libs\/crowdwalk\.jar/a \
FX_LIB="\/usr\/share\/openjfx\/lib"\nFX_MODS="javafx.base,javafx.controls,javafx.fxml,javafx.graphics,javafx.media,javafx.swing,javafx.web"\nFX_OPTS="--module-path \"$FX_LIB\" --add-modules $FX_MODS ${FX_OPENS}"' quickstart.sh && \
    sed -i 's|^echo ".*"|echo "$JAVA $JAVAOPT -Djdk.gtk.version=2 $FX_OPTS -jar $JAR $*"|' quickstart.sh && \
    sed -i 's|^\$JAVA .*|exec $JAVA $JAVAOPT -Djdk.gtk.version=2 $FX_OPTS -jar $JAR "$@"|' quickstart.sh && \
    chmod +x quickstart.sh

ENV LANG=ja_JP.UTF-8 \
    JAVA_OPTS='-Dgroovy.source.encoding=UTF-8 -Dfile.encoding=UTF-8'

WORKDIR /CrowdWalk/crowdwalk
CMD [ "bash" ]

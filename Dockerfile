FROM dart:latest AS build
WORKDIR /app

COPY pubspec.* ./
RUN dart pub get

COPY . .

RUN dart pub get --offline

# Build the application:
RUN dart compile exe bin/main.dart -o bin/bot

# Build minimal runtime image:
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/bin/bot /app/bin/

CMD ["/app/bin/bot"]
    
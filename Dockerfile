﻿# Sử dụng image .NET SDK để build ứng dụng
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /source
COPY . .

RUN dotnet restore "./DiscordBE/DiscordBE.csproj" --disable-parallel
RUN dotnet publish "./DiscordBE/DiscordBE.csproj" -c Release -o /app --no-restore

# Sử dụng image runtime để chạy ứng dụng
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build-env /app ./

EXPOSE 5000

ENTRYPOINT ["dotnet", "DiscordBE.dll"]

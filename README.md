# GitHub Pages — тест одной HTML-страницы

## Быстрый старт

1. Установи [GitHub CLI](https://cli.github.com/) и войди:
   ```powershell
   gh auth login -h github.com -p https -w
   ```
2. В этой папке:
   ```powershell
   cd C:\Users\SOI\.cursor\projects\c-Users-SOI-cursor-projects-empty-window\github-pages
   .\setup-github-pages.ps1
   ```
   Другое имя репозитория: `.\setup-github-pages.ps1 -RepoName my-test-page`

3. Открой сайт: `https://<твой-login>.github.io/service-test-page/`

## Ручная настройка (без скрипта)

```powershell
git init -b main
git add index.html .gitignore README.md
git commit -m "Add GitHub Pages test page"
gh repo create service-test-page --public --source=. --remote=origin --push
```

GitHub → репозиторий → **Settings** → **Pages** → Source: **Deploy from a branch**, branch **main**, folder **/ (root)**.

## Обновление страницы

```powershell
git add index.html
git commit -m "Update test page"
git push
```

Секреты и ключи API в `index.html` не клади — файл публичный.

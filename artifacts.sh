#!/usr/bin/env bash

set -e

rm -rf ./dist
mkdir ./dist

cp -r ./packages/next-app/.next/standalone/* ./dist/
cp -r ./packages/next-app/public ./dist/packages/next-app/public
cp -r ./packages/next-app/.next/static ./dist/packages/next-app/.next/static

echo 'Artifacts generated to ./dist'

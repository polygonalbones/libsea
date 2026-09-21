{
  mkShell,
  clang,
}:
mkShell {
  buildInputs = [
    clang
  ];
}

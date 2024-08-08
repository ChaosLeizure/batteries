import Lake

open Lake DSL

package std where
  moreLeanArgs := moreServerArgs.push "-DwarningAsError=true"
  moreServerArgs := moreServerArgs
where
  moreServerArgs := Id.run do
    let mut moreServerArgs := #["-Dlinter.missingDocs=true"]
    if get_config? disable_new_compiler |>.isSome then
      moreServerArgs := moreServerArgs.push "-Dcompiler.enableNew=false"
    moreServerArgs

@[default_target]
lean_lib Std

@[default_target]
lean_exe runLinter where
  root := `scripts.runLinter
  supportInterpreter := true

meta if get_config? doc = some "on" then
require «doc-gen4» from git "https://github.com/ChaosLeizure/doc-gen4" @ "6d8e3118ab526f8dfcabcbdf9f05dc34e5c423a8"

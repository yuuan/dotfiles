" ----------------------------------------
" phpactor
" ----------------------------------------

" 画面を横分割して定義元へのジャンプ
function! DefinitionJumpWithSplit()
    split
    call phpactor#GotoDefinition()
endfunction

" 画面を縦分割して定義元へのジャンプ
function! DefinitionJumpWithVSplit()
    vsplit
    call phpactor#GotoDefinition()
endfunction

" 新しいタブで定義元へジャンプ
function! DefinitionJumpInNewTab()
    tab sp
    call phpactor#GotoDefinition()
endfunction

" useの補完
nmap <silent><Leader>u      :<C-u>call phpactor#UseAdd()<CR>

" コンテキストメニューの起動(カーソル下のクラスやメンバに対して実行可能な選択肢を表示してくれます)
nmap <silent><Leader>mm     :<C-u>call phpactor#ContextMenu()<CR>

" ナビゲーションメニューの起動(クラスの参照元を列挙したり、他ファイルへのジャンプなど)
nmap <silent><Leader>nn     :<C-u>call phpactor#Navigate()<CR>

" カーソル下のクラスやメンバの定義元にジャンプ
nmap <silent><Leader>o      :<C-u>call phpactor#GotoDefinition()<CR>

" 編集中のクラスに対し各種の変更を加える(コンストラクタ補完、インタフェース実装など)
nmap <silent><Leader>tt     :<C-u>call phpactor#Transform()<CR>

" 新しいクラスを生成する(編集中のファイルに)
"nmap <silent><Leader>cc     :<C-u>call phpactor#ClassNew()<CR>

" 選択した範囲を変数に抽出する
"nmap <silent><Leader>ee     :<C-u>call phpactor#ExtractExpression(v:false)<CR>

" 選択した範囲を変数に抽出する
"vmap <silent><Leader>ee     :<C-u>call phpactor#ExtractExpression(v:true)<CR>

" 選択した範囲を新たなメソッドとして抽出する
"vmap <silent><Leader>em     :<C-u>call phpactor#ExtractMethod()<CR>

" カーソル下のクラスや変数の情報を表示する
" 他のエディタで、マウスカーソルをおいたときに表示されるポップアップなどに相当
vmap <silent><Leader>hh     :<C-u>call phpactor#Hover()<CR>

" 画面を縦分割して定義元へジャンプ
nmap <silent>gf :<C-u>call DefinitionJumpWithVSplit()<CR>

" 画面を横分割して定義元へジャンプ
nmap <silent><C-w>f :<C-u>call DefinitionJumpWithSplit()<CR>

" 新しいタブで定義元へジャンプ
nmap <silent><C-w>gf :<C-u>call DefinitionJumpInNewTab()<CR>

" カーソル下のクラスや変数の情報を表示する
" 他のエディタで、マウスカーソルをおいたときに表示されるポップアップなどに相当
nmap <silent><Leader>_ :<C-u>call phpactor#Hover()<CR>

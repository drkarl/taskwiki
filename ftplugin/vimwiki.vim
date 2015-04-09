let s:plugin_path = escape(expand('<sfile>:p:h:h'), '\')

if exists("g:taskwiki_measure_coverage")
  execute 'pyfile ' . s:plugin_path . '/taskwiki/coverage.py'
endif

execute 'pyfile ' . s:plugin_path . '/taskwiki/taskwiki.py'

augroup taskwiki
    " when saving the file sync the tasks from vimwiki to TW
    autocmd!
    execute "autocmd BufWrite *.".expand('%:e')." py WholeBuffer.update_to_tw()"
augroup END

" Split reports commands
command! -nargs=* TaskWikiProjects :py SplitProjects(<q-args>).execute()
command! -nargs=* TaskWikiProjectsSummary :py SplitSummary(<q-args>).execute()
command! -nargs=* TaskWikiBurndownDaily :py SplitBurndownDaily(<q-args>).execute()
command! -nargs=* TaskWikiBurndownMonthly :py SplitBurndownMonthly(<q-args>).execute()
command! -nargs=* TaskWikiBurndownWeekly :py SplitBurndownWeekly(<q-args>).execute()
command! -nargs=* TaskWikiCalendar :py SplitCalendar(<q-args>).execute()
command! -nargs=* TaskWikiGhistoryAnnual :py SplitGhistoryAnnual(<q-args>).execute()
command! -nargs=* TaskWikiGhistoryMonthly :py SplitGhistoryMonthly(<q-args>).execute()
command! -nargs=* TaskWikiHistoryAnnual :py SplitHistoryAnnual(<q-args>).execute()
command! -nargs=* TaskWikiHistoryMonthly :py SplitHistoryMonthly(<q-args>).execute()
command! -nargs=* TaskWikiStats :py SplitStats(<q-args>).execute()
command! -nargs=* TaskWikiTags :py SplitTags(<q-args>).execute()

" Commands that operate on tasks in the buffer
command! -range TaskWikiInfo :<line1>,<line2>py SelectedTasks().info()
command! -range TaskWikiEdit :<line1>,<line2>py SelectedTasks().edit()
command! -range TaskWikiLink :<line1>,<line2>py SelectedTasks().link()
command! -range TaskWikiGrid :<line1>,<line2>py SelectedTasks().grid()
command! -range TaskWikiDelete :<line1>,<line2>py SelectedTasks().delete()
command! -range TaskWikiStart :<line1>,<line2>py SelectedTasks().start()
command! -range TaskWikiStop :<line1>,<line2>py SelectedTasks().stop()
command! -range TaskWikiDone :<line1>,<line2>py SelectedTasks().done()
command! -range -nargs=* TaskWikiMod :<line1>,<line2>py SelectedTasks().modify(<q-args>)
command! -range -nargs=* TaskWikiAnnotate :<line1>,<line2>py SelectedTasks().annotate(<q-args>)

" Meta commands
command! TaskWikiInspect :py Meta().inspect_viewport()

" Disable <CR> as VimwikIFollowLink
if !hasmapto('<Plug>VimwikiFollowLink')
  nmap <Plug>NoVimwikiFollowLink <Plug>VimwikiFollowLink
endif

nmap <silent><buffer> <CR> :py Mappings.task_info_or_vimwiki_follow_link()<CR>

" Leader-related mappings. Mostly <Leader>t + <first letter of the action>
nmap <silent><buffer> <Leader>ta :TaskWikiAnnotate<CR>
nmap <silent><buffer> <Leader>tbd :TaskWikiBurndownDaily<CR>
nmap <silent><buffer> <Leader>tbw :TaskWikiBurndownWeekly<CR>
nmap <silent><buffer> <Leader>tbm :TaskWikiBurndownMonthly<CR>
nmap <silent><buffer> <Leader>tc :TaskWikiCalendar<CR>
nmap <silent><buffer> <Leader>td :TaskWikiDone<CR>
nmap <silent><buffer> <Leader>tD :TaskWikiDelete<CR>
nmap <silent><buffer> <Leader>te :TaskWikiEdit<CR>
nmap <silent><buffer> <Leader>tg :TaskWikiGrid<CR>
nmap <silent><buffer> <Leader>tGm :TaskWikiGhistoryMonthly<CR>
nmap <silent><buffer> <Leader>tGa :TaskWikiGhistoryAnnual<CR>
nmap <silent><buffer> <Leader>thm :TaskWikiHistoryMonthly<CR>
nmap <silent><buffer> <Leader>tha :TaskWikiHistoryAnnual<CR>
nmap <silent><buffer> <Leader>ti :TaskWikiInfo<CR>
nmap <silent><buffer> <Leader>tl :TaskWikiLink<CR>
nmap <silent><buffer> <Leader>tm :TaskWikiMod<CR>
nmap <silent><buffer> <Leader>tp :TaskWikiProjects<CR>
nmap <silent><buffer> <Leader>ts :TaskWikiProjectsSummary<CR>
nmap <silent><buffer> <Leader>tS :TaskWikiStats<CR>
nmap <silent><buffer> <Leader>tt :TaskWikiTags<CR>
nmap <silent><buffer> <Leader>t+ :TaskWikiStart<CR>
nmap <silent><buffer> <Leader>t- :TaskWikiStop<CR>

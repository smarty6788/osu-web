###*
*    Copyright 2015 ppy Pty. Ltd.
*
*    This file is part of osu!web. osu!web is distributed with the hope of
*    attracting more community contributions to the core ecosystem of osu!.
*
*    osu!web is free software: you can redistribute it and/or modify
*    it under the terms of the Affero GNU General Public License version 3
*    as published by the Free Software Foundation.
*
*    osu!web is distributed WITHOUT ANY WARRANTY; without even the implied
*    warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
*    See the GNU Affero General Public License for more details.
*
*    You should have received a copy of the GNU Affero General Public License
*    along with osu!web.  If not, see <http://www.gnu.org/licenses/>.
*
###
{div,a,i,span} = React.DOM
el = React.createElement

class Contest.Voting.EntryList extends Contest.Voting.BaseEntryList
  render: ->
    return null unless @state.contest.entries.length > 0

    if @state.contest.show_votes
      totalVotes = _.sumBy @state.contest.entries, (i) -> i.results.votes

    entries = @state.contest.entries.map (entry) =>
      el Contest.Voting.Entry,
        key: entry.id,
        entry: entry,
        waitingForResponse: @state.waitingForResponse,
        options: @state.options,
        contest: @state.contest,
        selected: @state.selected,
        winnerVotes: if @state.contest.show_votes then _.maxBy(@state.contest.entries, (i) -> i.results.votes).results.votes
        totalVotes: if @state.contest.show_votes then totalVotes

    div className: 'contest-voting-list__table',
      div className: 'contest-voting-list__header',
        if @state.options.showPreview
          div className: 'contest-voting-list__icon'
        div className: 'contest-voting-list__wrapperthing',
          div className: 'contest-voting-list__header-title', 'entry'
          div className: 'contest-voting-list__header-votesummary', colSpan: (if @props.contest.show_votes then 2 else 1),
            div className: 'contest__vote-summary-text', 'votes'
            el Contest.Voting.VoteSummary, voteCount: @state.selected.length, maxVotes: @state.contest.max_votes
      div {}, entries

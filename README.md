# Group-Entries

[![Pharo P14](https://img.shields.io/badge/Pharo-P14-2c98f0.svg)](https://github.com/pharo-completion/group-entries)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://github.com/pharo-completion/group-entries/blob/master/LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/pharo-completion/group-entries/pulls)
[![Status: Active](https://img.shields.io/badge/status-active-success.svg)](https://github.com/pharo-completion/group-entries)

Group Entries is a Pharo extension that clusters raw completion entries into meaningful groups, making results easier to browse and understand. Entries that don’t fit any group remain as standalone completion candidates, ensuring nothing is lost.

---

<img width="770" height="397" alt="group-entries" src="https://github.com/user-attachments/assets/bedd558b-8b3d-4155-b0fc-aaeefd54c692" />

---

```smalltalk
Metacello new
  githubUser: 'pharo-completion' project: 'group-entries' commitish: 'main' path: 'src';
  baseline: 'GroupEntries';
  load.
```

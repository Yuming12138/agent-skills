# Agent Skills Collection

面向 Codex、Claude Code、Cursor 等 coding agent 的可复用 skills 集合。

本仓库是一个便于团队协作的打包版本：

- `skills/powershell-command-safety/`：本仓库维护的 PowerShell、SSH、Git 和远程操作安全 skill。
- `skills/ui-craft/`：来自上游的 UI 设计与实现 skill。
- `skills/ui-ux-pro-max/`：来自上游的 UI/UX 设计智能 skill。
- `skills/web-design-guidelines/`：来自上游的 Web 界面规范检查 skill。

第三方 skill 保留了各自的许可证原文；来源、版权和版本信息见 [NOTICE.md](NOTICE.md) 与 [manifest.json](manifest.json)。

## 使用方式

### Codex 项目级安装

将本仓库克隆到项目根目录，并把 `skills/` 下需要的目录复制到项目的 `.codex/skills/`：

```powershell
git clone https://github.com/Yuming12138/agent-skills.git
Copy-Item -Recurse -Force .\agent-skills\skills\ui-craft .\.codex\skills\
Copy-Item -Recurse -Force .\agent-skills\skills\ui-ux-pro-max .\.codex\skills\
Copy-Item -Recurse -Force .\agent-skills\skills\web-design-guidelines .\.codex\skills\
Copy-Item -Recurse -Force .\agent-skills\skills\powershell-command-safety .\.codex\skills\
```

也可以直接运行：

```powershell
.\agent-skills\install.ps1 -Destination .\.codex\skills
```

### 用户级安装

将 `-Destination` 指向 agent 的用户级 skills 目录即可。例如 Windows 上的 Codex 通常使用：

```powershell
.\agent-skills\install.ps1 -Destination "$env:USERPROFILE\.codex\skills"
```

不同 agent 对目录位置的约定可能不同；安装前请以对应 agent 的文档为准。安装脚本默认复制全部四个 skill，也可以用 `-Skill` 指定一个或多个名称。

## 维护约定

- 第三方 skill 更新时，在 `manifest.json` 中记录上游 commit，并同步对应的 `LICENSE`。
- 对第三方文件的本地修改应在 `NOTICE.md` 或变更记录中说明。
- 仓库级 `LICENSE` 只适用于本仓库原创的安装脚本、清单和协作文档；第三方目录继续适用其各自许可证。

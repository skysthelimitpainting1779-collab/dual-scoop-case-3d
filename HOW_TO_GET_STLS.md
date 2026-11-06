The print-ready STLs and GLBs are currently on the `cad-workstation` sprite at:

```
~/dual-scoop/
├── PRINT_scoop.stl
├── PRINT_full_open_case.stl
├── PRINT_case_half.stl
├── dual_scoop_full.glb
├── dual_scoop_case.glb
└── scoop.glb
```

To pull them:

```bash
sprite exec -s cad-workstation -- cat ~/dual-scoop/PRINT_full_open_case.stl > PRINT_full_open_case.stl
sprite exec -s cad-workstation -- cat ~/dual-scoop/PRINT_scoop.stl > PRINT_scoop.stl
sprite exec -s cad-workstation -- cat ~/dual-scoop/dual_scoop_full.glb > dual_scoop_full.glb
```

Or download directly from the sprite filesystem.

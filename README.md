# Arvore Sintatica

```bash
prog
├── stat (ifStatement)
│   ├── IF
│   ├── LPAREN
│   ├── expr
│   │   ├── term
│   │   │   └── factor
│   │   │       └── IDENTIFIER: x
│   │   ├── EQ
│   │   └── term
│   │       └── factor
│   │           └── NUMBER: 10
│   ├── RPAREN
│   └── stat (expressionStatement)
│       ├── expr
│       │   ├── term
│       │   │   └── factor
│       │   │       └── IDENTIFIER: x
│       │   ├── PLUS
│       │   └── term
│       │       └── factor
│       │           └── NUMBER: 1
│       └── SEMICOLON
├── stat (block)
│   ├── LBRACE
│   ├── stat (assignment)
│   │   ├── IDENTIFIER: y
│   │   ├── ASSIGN
│   │   ├── expr
│   │   │   └── term
│   │   │       └── factor
│   │   │           └── NUMBER: 5
│   │   └── SEMICOLON
│   ├── stat (returnStatement)
│   │   ├── RETURN
│   │   └── SEMICOLON
│   └── RBRACE

```

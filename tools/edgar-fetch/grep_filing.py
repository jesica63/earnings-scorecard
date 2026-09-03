#!/usr/bin/env python3
"""
在指定公司的 10-Q / 10-K 全文（含 HTML/JSON/XML 各版本）中搜尋關鍵字，
用於找出藏在附注中、沒進標準三表的揭露（客戶集中度、股數變化、可轉債條款等）。

用法：
    python grep_filing.py AAOI "top ten customers" --form 10-Q --index 0
    python grep_filing.py AAOI "shares outstanding" --form 10-Q --index 0

需要先設定環境變數 SEC_EDGAR_IDENTITY（SEC 要求的真實聯絡身分）：
    export SEC_EDGAR_IDENTITY="你的名字 你的信箱@example.com"
"""
import argparse
import os
import sys

from edgar import Company, set_identity

def main():
    parser = argparse.ArgumentParser(description="在 SEC EDGAR 財報全文中搜尋關鍵字")
    parser.add_argument("ticker", help="股票代號，如 AAOI、NVDA、AMD")
    parser.add_argument("keyword", help="要搜尋的關鍵字或片語")
    parser.add_argument("--form", default="10-Q", choices=["10-Q", "10-K"], help="申報表格類型")
    parser.add_argument("--index", type=int, default=0, help="第幾份最新申報，0=最新")
    args = parser.parse_args()

    identity = os.environ.get("SEC_EDGAR_IDENTITY")
    if not identity:
        print(
            "錯誤：未設定 SEC_EDGAR_IDENTITY 環境變數。\n"
            '請先執行：export SEC_EDGAR_IDENTITY="你的名字 你的信箱@example.com"',
            file=sys.stderr,
        )
        sys.exit(1)
    set_identity(identity)

    company = Company(args.ticker)
    filings = company.get_filings(form=args.form)
    filing = filings[args.index]

    print(f"=== FILING INFO ===\n{filing}\n")

    filing_obj = filing.obj()
    result = filing_obj.grep(args.keyword)
    print(result)

if __name__ == "__main__":
    main()

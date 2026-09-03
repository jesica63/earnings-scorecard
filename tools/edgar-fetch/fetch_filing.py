#!/usr/bin/env python3
"""
抓取指定公司最新（或第 N 份）10-Q / 10-K 的三張結構化財報表。

用法：
    python fetch_filing.py AAOI --form 10-Q --index 0
    python fetch_filing.py NVDA --form 10-K --index 1

需要先設定環境變數 SEC_EDGAR_IDENTITY（SEC 要求的真實聯絡身分）：
    export SEC_EDGAR_IDENTITY="你的名字 你的信箱@example.com"
"""
import argparse
import os
import sys

from edgar import Company, set_identity

def main():
    parser = argparse.ArgumentParser(description="抓取 SEC EDGAR 財報三表")
    parser.add_argument("ticker", help="股票代號，如 AAOI、NVDA、AMD")
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

    print("=== BALANCE SHEET ===")
    print(filing_obj.balance_sheet)
    print()

    print("=== INCOME STATEMENT ===")
    print(filing_obj.income_statement)
    print()

    print("=== CASH FLOW STATEMENT ===")
    print(filing_obj.cash_flow_statement)

if __name__ == "__main__":
    main()

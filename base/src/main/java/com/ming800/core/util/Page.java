package com.ming800.core.util;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 12-10-31
 * Time: 下午3:46
 * To change this template use File | Settings | File Templates.
 */
public class Page {

    private List list;

    private int pageIndex = 1;
    private int pageRecords = 20;
    private int pageCount;
    private int recordCount;
    private int recordIndex;
    private int pageStep = 10;
    private int pageStepStart;
    private int pageStepEnd;

    private int nextPage;
    private int previousPage;
    private int nnextPage;
    private int ppreviousPage;

    public List getList() {
        return list;
    }

    public void setList(List list) {
        this.list = list;
    }

    public int getPageIndex() {
        return pageIndex;
    }

    public void setPageIndex(int pageIndex) {
        this.pageIndex = pageIndex;
    }

    public int getPageRecords() {
        return pageRecords;
    }

    public void setPageRecords(int pageRecords) {
        this.pageRecords = pageRecords;
    }

    public synchronized int getPageCount() {
        this.pageCount = this.recordCount % this.pageRecords == 0 ? this.recordCount / this.pageRecords : this.recordCount / this.pageRecords + 1;
        return pageCount;
    }

    public void setPageCount(int pageCount) {
        this.pageCount = pageCount;
    }

    public int getRecordCount() {
        return recordCount;
    }

    public void setRecordCount(int recordCount) {
        this.recordCount = recordCount;
    }

    public synchronized int getRecordIndex() {
        this.recordIndex = this.pageIndex == 0 ? 1 : (this.pageIndex - 1) * this.pageRecords;
        return recordIndex;
    }

    public int getPageStep() {
        return pageStep;
    }

    public void setPageStep(int pageStep) {
        this.pageStep = pageStep;
    }

    public synchronized int getPageStepStart() {
        int start = this.pageIndex % this.pageStep == 0 ? this.pageIndex / this.pageStep : this.pageIndex / this.pageStep + 1;
        this.pageStepStart = start == 1 ? 1 : start * this.pageStep - this.pageStep + 1;
        return pageStepStart;
    }

    public synchronized int getPageStepEnd() {
        if (this.pageCount > this.pageStep) {
            if (this.pageIndex == this.pageCount) {
                this.pageStepEnd = this.pageStepStart + this.pageCount % this.pageStep;
            } else {
                this.pageStepEnd = this.pageCount - this.pageStepStart < this.pageCount % this.pageStep ? this.pageCount + 1 : this.pageStepStart + this.pageStep;
            }
        } else {
            this.pageStepEnd = this.pageCount + 1;
        }
        return pageStepEnd;
    }

    public synchronized int getNextPage() {
        this.nextPage = this.pageIndex == this.pageCount ? this.pageCount : this.pageIndex + 1;
        return nextPage;
    }

    public synchronized int getPreviousPage() {
        this.previousPage = this.pageIndex == 1 ? 1 : this.pageIndex - 1;
        return previousPage;
    }

    public synchronized int getNnextPage() {
        if (this.pageIndex + this.pageStep > this.pageCount) {
            if (this.pageStepEnd > this.pageCount) this.nnextPage = this.pageIndex;
            else this.nnextPage = this.pageStepEnd;
        } else {
            if (this.pageIndex + this.pageIndex % this.pageStep == 0) this.nnextPage = this.pageIndex;
            else this.nnextPage = this.pageIndex + (this.pageStep - this.pageIndex % this.pageStep + 1);
        }
        //this.nnextPage = this.pageIndex + this.pageStep > this.pageCount ? (this.pageStepEnd > this.pageCount ? this.pageIndex : this.pageStepEnd + 1) : (this.pageIndex + this.pageIndex % this.pageStep == 0 ? 0 : this.pageStep - this.pageIndex % this.pageStep  + 1);
        return nnextPage;
    }

    public synchronized int getPpreviousPage() {
        this.ppreviousPage = this.pageIndex > this.pageStep ? this.pageIndex - this.pageStep - this.pageIndex % this.pageStep + 1 : 1;
        return ppreviousPage;
    }

}

package com.ming800.core.taglib;

public class PageEntity {
    /*public PageEntity(){
         this.size = size==0 ? 20:size;
    }*/
    private int index = 1;           //页数序号        p 标示page
    private int size = 10;        //每页的记录条数
    private int pCount;               //总共多少页
    private int count;          //记录总条数      r标示record
    private int rIndex;          //条数数序号
    //private int pageStep = 10;
    //private int pageStepStart;
    //private int pageStepEnd;

    private int next;               //下一页
    private int previous;            //上一页
    private int end;               //最后一页
    private int first;           //第一页
    //private static int xmlRecords=0;
    public static String PARAM_NAME_PAGEINDEX = "pageEntity.index";
    public static String PARAM_NAME_PAGERECORDS = "pageEntity.size";
    public static String PARAM_NAME_PAGESTEP = "pageEntity.pageStep";

    public int getIndex() {
        return index;
    }

    public void setIndex(int index) {
        this.index = index;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public synchronized int getpCount() {
        //   if(this.xmlRecords!=0)this.size =this.xmlRecords;
        this.pCount = this.count % this.size == 0 ? this.count / this.size : this.count / this.size + 1;
        return pCount;
    }

    public void setpCount(int pCount) {
        this.pCount = pCount;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public synchronized int getrIndex() {
        //   if(this.xmlRecords!=0)this.size =this.xmlRecords;
        this.rIndex = this.index == 0 ? 1 : (this.index - 1) * this.size;
        return rIndex;
    }

	/*public int getPageStep() {
        return pageStep;
	}

	public void setPageStep(int pageStep) {
		this.pageStep = pageStep;
	}

	public synchronized int getPageStepStart() {
		int start = this.index % this.pageStep == 0 ? this.index / this.pageStep : this.index / this.pageStep + 1;
		this.pageStepStart = start == 1 ? 1 : start * this.pageStep - this.pageStep + 1;
		return pageStepStart;
	}

	public synchronized int getPageStepEnd() {
		if (this.pCount > this.pageStep) {
			if (this.index == this.pCount) {
				this.pageStepEnd = this.pageStepStart + this.pCount % this.pageStep;
			} else {
				this.pageStepEnd = this.pCount - this.pageStepStart < this.pCount % this.pageStep ? this.pCount + 1 : this.pageStepStart + this.pageStep;
			}
		} else {
			this.pageStepEnd = this.pCount + 1;
		}
		return pageStepEnd;
	}*/

    public synchronized int getNext() {
        this.next = this.index == this.pCount ? this.pCount : this.index + 1;
        return next;
    }

    public synchronized int getPrevious() {
        this.previous = this.index == 1 ? 1 : this.index - 1;
        return previous;
    }

	/*public synchronized int getNnextPage() {
        if(this.index + this.pageStep > this.pCount){
           if(this.pageStepEnd > this.pCount)this.end = this.index;
           else this.end =this.pageStepEnd;
        }else{
            if(this.index + this.index % this.pageStep == 0)this.end=this.index;
            else this.end =this.index +(this.pageStep-this.index %this.pageStep+1);
        }
		//this.end = this.index + this.pageStep > this.pCount ? (this.pageStepEnd > this.pCount ? this.index : this.pageStepEnd + 1) : (this.index + this.index % this.pageStep == 0 ? 0 : this.pageStep - this.index % this.pageStep  + 1);
		return end;
	}

	public synchronized int getPpreviousPage() {
		this.first = this.index > this.pageStep ? this.index - this.pageStep - this.index % this.pageStep + 1 : 1;
		return first;
	}*/

}

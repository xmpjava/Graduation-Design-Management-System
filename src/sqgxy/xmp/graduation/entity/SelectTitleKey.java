package sqgxy.xmp.graduation.entity;

public class SelectTitleKey {
    private String sId;

    private Long titlId;

    public String getsId() {
        return sId;
    }

    public void setsId(String sId) {
        this.sId = sId == null ? null : sId.trim();
    }

    public Long getTitlId() {
        return titlId;
    }

    public void setTitlId(Long titlId) {
        this.titlId = titlId;
    }
}
public interface QuotationSync {
    Boolean confirmProductExistByCode(String extCode);
    Integer searchProductByCode(String prodCode);
}
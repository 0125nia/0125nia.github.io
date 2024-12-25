fn main() -> io::Result<()> {
    let src_path = Path::new("src/SUMMARY.md");
    let file = File::open(&src_path)?;
}

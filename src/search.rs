use std::path::Path;
use tantivy::collector::TopDocs;
use tantivy::query::QueryParser;
use tantivy::schema::*;
use tantivy::{doc, Index};
use tantivy_tokenizer_tiny_segmenter::tokenizer::TinySegmenterTokenizer;

pub fn index_document(index_directory: &Path) {
    let mut schema_builder = Schema::builder();

    let text_field_indexing = TextFieldIndexing::default()
        .set_tokenizer("tinyseg")
        .set_index_option(IndexRecordOption::WithFreqsAndPositions);
    let text_options = TextOptions::default()
        .set_indexing_options(text_field_indexing)
        .set_stored();
    let body = schema_builder.add_text_field("body", text_options);

    let schema = schema_builder.build();
    let index = Index::create_in_dir(index_directory, schema.clone()).unwrap();
    index
        .tokenizers()
        .register("tinyseg", TinySegmenterTokenizer {});
    let mut index_writer = index.writer(50_000_000).unwrap();
    index_writer.add_document(doc!(
        body => "日本語の本文",
    ));
    index_writer.add_document(doc!(
        body => r#"「この早起きというのは」と、彼は思った、「人間をまったく薄ばかにしてしまうのだ。人間は眠りをもたなければならない。
                   ほかのセールスマンたちはまるでハレムの女たちのような生活をしている。たとえばおれがまだ午前中に宿へもどってきて、
                   取ってきた注文を書きとめようとすると、やっとあの連中は朝食のテーブルについているところだ。
                   そんなことをやったらおれの店主がなんていうか、見たいものだ。おれはすぐさまくびになってしまうだろう。"#,
    ));
    index_writer.add_document(doc!(
        body => r#"吾輩は猫である。名前はまだ無い。
                   どこで生れたかとんと見当がつかぬ。何でも薄暗いじめじめした所でニャーニャー泣いていた事だけは記憶している。
                   吾輩はここで始めて人間というものを見た。しかもあとで聞くとそれは書生という人間中で一番獰悪な種族であったそうだ。
                   この書生というのは時々我々を捕えて煮て食うという話である。しかしその当時は何という考もなかったから別段恐しいとも思わなかった。
                   ただ彼の掌に載せられてスーと持ち上げられた時何だかフワフワした感じがあったばかりである。
                   掌の上で少し落ちついて書生の顔を見たのがいわゆる人間というものの見始であろう。この時妙なものだと思った感じが今でも残っている。
                   第一毛をもって装飾されべきはずの顔がつるつるしてまるで薬缶だ。その後猫にもだいぶ逢ったがこんな片輪には一度も出会わした事がない。
                   のみならず顔の真中があまりに突起している。そうしてその穴の中から時々ぷうぷうと煙を吹く。
                   どうも咽せぽくて実に弱った。これが人間の飲む煙草というものである事はようやくこの頃知った。"#,
    ));
    index_writer.commit().unwrap();
}

pub fn index_document_im() -> Index {
    let mut schema_builder = Schema::builder();

    let text_field_indexing = TextFieldIndexing::default()
        .set_tokenizer("tinyseg")
        .set_index_option(IndexRecordOption::WithFreqsAndPositions);
    let text_options = TextOptions::default()
        .set_indexing_options(text_field_indexing)
        .set_stored();
    let body = schema_builder.add_text_field("body", text_options);

    let schema = schema_builder.build();
    let index = Index::create_in_ram(schema.clone());
    index
        .tokenizers()
        .register("tinyseg", TinySegmenterTokenizer {});
    let mut index_writer = index.writer(50_000_000).unwrap();
    index_writer.add_document(doc!(
        body => "日本語の本文",
    ));
    index_writer.add_document(doc!(
        body => r#"「この早起きというのは」と、彼は思った、「人間をまったく薄ばかにしてしまうのだ。人間は眠りをもたなければならない。
                   ほかのセールスマンたちはまるでハレムの女たちのような生活をしている。たとえばおれがまだ午前中に宿へもどってきて、
                   取ってきた注文を書きとめようとすると、やっとあの連中は朝食のテーブルについているところだ。
                   そんなことをやったらおれの店主がなんていうか、見たいものだ。おれはすぐさまくびになってしまうだろう。"#,
    ));
    index_writer.add_document(doc!(
        body => r#"吾輩は猫である。名前はまだ無い。
                   どこで生れたかとんと見当がつかぬ。何でも薄暗いじめじめした所でニャーニャー泣いていた事だけは記憶している。
                   吾輩はここで始めて人間というものを見た。しかもあとで聞くとそれは書生という人間中で一番獰悪な種族であったそうだ。
                   この書生というのは時々我々を捕えて煮て食うという話である。しかしその当時は何という考もなかったから別段恐しいとも思わなかった。
                   ただ彼の掌に載せられてスーと持ち上げられた時何だかフワフワした感じがあったばかりである。
                   掌の上で少し落ちついて書生の顔を見たのがいわゆる人間というものの見始であろう。この時妙なものだと思った感じが今でも残っている。
                   第一毛をもって装飾されべきはずの顔がつるつるしてまるで薬缶だ。その後猫にもだいぶ逢ったがこんな片輪には一度も出会わした事がない。
                   のみならず顔の真中があまりに突起している。そうしてその穴の中から時々ぷうぷうと煙を吹く。
                   どうも咽せぽくて実に弱った。これが人間の飲む煙草というものである事はようやくこの頃知った。"#,
    ));
    index_writer.commit().unwrap();
    index
}

pub fn search_document_im(query: &str) -> String {
    let index = index_document_im();
    index
        .tokenizers()
        .register("tinyseg", TinySegmenterTokenizer {});
    let schema = index.schema();

    let reader = index.reader().unwrap();
    let searcher = reader.searcher();

    let default_fields: Vec<Field> = schema
        .fields()
        .iter()
        .enumerate()
        .map(|(i, _)| Field(i as u32))
        .collect();
    let query_parser = QueryParser::new(schema.clone(), default_fields, index.tokenizers().clone());

    let query = query_parser.parse_query(query).unwrap();

    let mut docs = Vec::new();
    for (_, doc_address) in searcher.search(&query, &TopDocs::with_limit(10)).unwrap() {
        let retrieved_doc = searcher.doc(doc_address).unwrap();
        // println!("{}", schema.to_json(&retrieved_doc));
        docs.push(schema.to_json(&retrieved_doc));
    }
    format!("[{}]", docs.join(","))
}

pub fn search_document(index_directory: &Path, query: &str) -> String {
    let index = Index::open_in_dir(index_directory).unwrap();
    index
        .tokenizers()
        .register("tinyseg", TinySegmenterTokenizer {});
    let schema = index.schema();

    let reader = index.reader().unwrap();
    let searcher = reader.searcher();

    let default_fields: Vec<Field> = schema
        .fields()
        .iter()
        .enumerate()
        .map(|(i, _)| Field(i as u32))
        .collect();
    let query_parser = QueryParser::new(schema.clone(), default_fields, index.tokenizers().clone());

    let query = query_parser.parse_query(query).unwrap();

    let mut docs = Vec::new();
    for (_, doc_address) in searcher.search(&query, &TopDocs::with_limit(10)).unwrap() {
        let retrieved_doc = searcher.doc(doc_address).unwrap();
        // println!("{}", schema.to_json(&retrieved_doc));
        docs.push(schema.to_json(&retrieved_doc));
    }
    format!("[{}]", docs.join(","))
}

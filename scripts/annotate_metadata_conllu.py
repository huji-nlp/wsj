import re

from configargparse import ArgParser
from tqdm import tqdm


def read(filename):
    docs = {}
    doc_id = None
    with open(filename, encoding="utf-8") as f:
        for line in tqdm(f, unit=" lines", desc="Reading " + filename):
            m = re.match("^# doc_id = (.*)", line)
            if m:
                doc_id = m.group(1)
            else:
                sents = docs.setdefault(doc_id, [[]])
                stripped = line.strip()
                if stripped:
                    sents[-1].append(stripped)
                else:
                    sents.append([])
    return docs


def annotate(docs, filename):
    with open(filename, "w", encoding="utf-8") as f:
        for doc_id, sents in tqdm(sorted(docs.items()), unit=" lines", desc="Writing " + filename):
            print("# newdoc id = %s" % doc_id, file=f)
            for i, lines in enumerate(filter(None, sents), start=1):
                print("# sent_id = %s.%d" % (doc_id, i), file=f)
                print("# text = " + " ".join(l.split("\t")[1] for l in lines), file=f)
                for line in lines:
                    print(line, file=f)
                print(file=f)


def main():
    argparser = ArgParser()
    argparser.add_argument("files", nargs="+")
    args = argparser.parse_args()
    for filename in args.files:
        annotate(read(filename), filename + ".annotated")


if __name__ == "__main__":
    main()
